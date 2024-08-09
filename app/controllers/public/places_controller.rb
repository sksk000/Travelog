class Public::PlacesController < ApplicationController
  def new
    @place = Place.new
    @post_id = params[:post_id]
    @place_num = Place.where(post_id: @post_id).pluck(:place_num).uniq.sort
  end


  def create
    @place = Place.new(place_params)
    @place.post_id = params[:post_id]
    save_place_num()

    if @place.save
      redirect_to post_path(@place.post_id)
    else
      render :new
    end
  end

  def edit
    @place = Place.where(post_id: params[:post_id]).order(:place_num)
    @post_id = params[:post_id]
  end

  def update
    datas = params[:place]
    byebug
    datas.each do | id, attrs |
      data = Place.find(id)
      data.update(attrs)
    end
    redirect_to post_path(params[:post_id])
  end

  private
  def place_params
    params.require(:place).permit(:address, :place_name, :comment)
  end

  def places_params
    params.require(:place).permit(attributes:{place_name: })
  end

  def save_place_num
    target_num = params[:place][:place_num]
    if target_num == "新規追加"
      @place.place_num = Place.maximum(:place_num).to_i + 1
    else
      @place.place_num = params[:place][:place_num]

      datas= Place.where(post_id: params[:post_id]).where('place_num >= ?', target_num)
      Place.transaction do
        datas.find_each do | data |
          data.update!(place_num: data.place_num + 1)
        end
      end

    end
  end
end
