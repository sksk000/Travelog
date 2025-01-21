class Public::PlacesController < ApplicationController
  def new
    @post_id = params[:post_id]
  end

  def edit
    @place = Place.where(post_id: params[:post_id]).order(:place_num)
    @post_id = params[:post_id]

    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    place_params.each do |place_param|
      place = Place.new(place_param.merge(post_id: params[:post_id]))
      unless place.save
        render json: { message: "投稿に失敗しました。: #{place.errors.full_messages.join(', ')}" }, status: :unprocessable_entity
        return
      end
    end
    render json: { message: '投稿に成功しました。', redirect_url: post_path(params[:post_id]) }, status: :created
  end

  def update
    client_place_ids = update_params.map { |place| place[:id].to_s.strip }.reject { |id| id == "null" || id.blank? }
    Place.where(post_id: params[:post_id]).each do |place|
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
          return
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
            return
          end
        end
      end
    end

    # 必要なレスポンスを返す
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
