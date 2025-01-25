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
    is_success = true

    client_place_ids = update_params.map { |place| place[:id].to_s.strip }.reject { |id| id == "null" || id.blank? }
    Place.where(post_id: params[:post_id]).find_each do |place|
      place.destroy unless client_place_ids.include?(place.id.to_s)
    end

    update_params.each do |place_param|
      if place_param[:id] == "null"
        # 新規作成の処理
        new_place = Place.new(
          place_name: place_param[:place_name],
          comment: place_param[:comment],
          latitude: place_param[:latitude],
          longitude: place_param[:longitude],
          good: place_param[:good],
          place_num: place_param[:place_num],
          post_id: params[:post_id],
          image: place_param[:image]
        )
        unless new_place.save
          render json: { message: "投稿に失敗しました。: #{new_place.errors.full_messages.join(', ')}" }, status: :unprocessable_entity
          is_success = false
          break
        end
      else
        # 既存のレコードの更新処理
        place = Place.find_by(id: place_param[:id])
        if place
          place.image.attach(params[:place][:image]) if params[:place][:image].present?

          unless place.update(
            place_name: place_param[:place_name],
            comment: place_param[:comment],
            latitude: place_param[:latitude],
            longitude: place_param[:longitude],
            good: place_param[:good],
            place_num: place_param[:place_num]
          )
            render json: { message: "投稿に失敗しました。 #{place.id}: #{place.errors.full_messages.join(', ')}" }, status: :unprocessable_entity
            is_success = false
            break
          end
        end
      end
    end

    # 必要なレスポンスを返す
    render json: { message: '投稿を更新しました', redirect_url: post_path(params[:post_id]) } if is_success == true
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
