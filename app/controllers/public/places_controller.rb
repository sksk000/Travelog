class Public::PlacesController < ApplicationController
  def new
    @place = Place.new
    @post_id = params[:post_id]
    @place_num = Place.where(post_id: @post_id).pluck(:place_num).uniq.sort
  end


  def create
    @place = Place.new(place_params)
    @place.post_id = params[:post_id]
    @place.place_num = Place.maximum(:place_num).to_i + 1

    save_place_num()

     if @place.save
      redirect_to post_path(@place.post_id)
    else
      render :new
    end
  end

  private
  def place_params
    params.require(:place).permit(:address, :place_name)
  end

  def save_place_num
    target_num = params[:place][:place_num]
    if target_num == "新規追加"
      @place.place_num = Place.maximum(:place_num).to_i + 1
    else
      data = Place.where(post_id: params[:post_id]).where('place_num >= ?', target_num)
      byebug

      Place.transaction do
        #Place.where(post_id: params[:post_id]).where('place_num >= ?', target_num).update_all('place_num = place_num + 1')
      end
    end

  end

end
