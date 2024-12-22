class Public::PlacesController < ApplicationController
  def new
    @post_id = params[:post_id]
  end


  def create
    place_params.each do |place_param|

      place = Place.new(place_param.merge(post_id: params[:post_id]))
      unless place.save
        render json: { error: '投稿に失敗しました', details: place.errors.full_messages }, status: :unprocessable_entity
        return
      end
    end
    render json: { message: '投稿が成功しました', redirect_url: post_path(params[:post_id]) }, status: :created

  end

  def edit
    @place = Place.where(post_id: params[:post_id]).order(:place_num)
    @post_id = params[:post_id]

    respond_to do |format|
      format.html
      format.json
    end
  end

  def update
    places_data = place_params # place_params を呼び出してデータ取得

    ActiveRecord::Base.transaction do

      Place.where(post_id: params[:post_id]).destroy_all

      places_data.each do |place_data|
        place = Place.new(place_data.except(:image).merge(post_id: params[:post_id]))

        # 画像データを適切にアタッチ
        if place_data[:image].is_a?(ActionDispatch::Http::UploadedFile)
          place.image.attach(place_data[:image])
        end

        unless place.save
          render json: { error: '投稿に失敗しました', details: place.errors.full_messages }, status: :unprocessable_entity and return
        end
      end
    end
    render json: { message: '投稿が成功しました', redirect_url: post_path(params[:post_id]) }
  end

  private
  def place_params
    params[:place].values.map do | place |
      ActionController::Parameters.new(place).permit(:place_name, :comment, :image, :good, :latitude, :longitude, :place_num )
    end
  end

  def update_params(attrs)
    attrs.permit(:place_name, :address, :comment)
  end
end
