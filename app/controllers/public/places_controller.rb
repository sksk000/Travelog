class Public::PlacesController < ApplicationController
  def new
    @post_id = params[:post_id]
  end

  def edit
    @place = Place.getPlaces(params[:post_id])
    @post_id = params[:post_id]

    respond_to do |format|
      format.html
      format.json
    end
  end

  # rubocop:disable Style/Next: Use next to skip iteration. unless place.saveに投稿失敗した場合はあとの処理は行わず、ループを抜けたいため。
  def create
    errors = Place.createPlace(place_params, params[:post_id])
    if errors.empty?
       render json: { message: '投稿に成功しました。', redirect_url: post_path(params[:post_id]) }, status: :created
    else
      render json: { message: "投稿に失敗しました。: #{errors.join(', ')}" }, status: :unprocessable_entity
    end
  end
  # rubocop:enable Style/Next: Use next to skip iteration.

  def update
    client_place_ids = update_params.map { |place| place[:id].to_s.strip }.reject { |id| id == "null" || id.blank? }
    Place.where(post_id: params[:post_id]).find_each do |place|
      place.destroy unless client_place_ids.include?(place.id.to_s)
    end

    ActiveRecord::Base.transaction do
      update_params.each do |place_param|
        error = Place.update_Or_CreatePlace(params[:post_id], place_param)
        unless error.empty?
          render json: { message: "投稿に失敗しました。: #{error}" }, status: :unprocessable_entity
        end
      end
    end

    render json: { message: '投稿を更新しました', redirect_url: post_path(params[:post_id]) }
  end

  private

  def place_params
    params[:place].values.map do |place|
      ActionController::Parameters.new(place).permit(:place_name, :comment, :image, :good, :latitude, :longitude, :place_num)
    end
  end

  def update_params
    params[:place].values.map do |place|
      ActionController::Parameters.new(place).permit(:place_name, :comment, :image, :good, :latitude, :longitude, :place_num, :id).to_h
    end
  end
end
