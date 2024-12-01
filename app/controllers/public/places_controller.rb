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
  end

  def update
    datas = params[:place]
    datas.each do | id, attrs |
      data = Place.find(id)
      data.update(update_params(attrs))
    end
    redirect_to post_path(params[:post_id])
  end

  private
  def place_params
    params.require(:place).map do | place |
      place.permit(:place_name, :comment, :image, :good, :latitude, :longitude, :place_num )
    end
  end

  def update_params(attrs)
    attrs.permit(:place_name, :address, :comment)
  end
end
