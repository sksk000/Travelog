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

  def set_place_num(place_num)
    if place_num == "新規追加"
      @place.place_num = Place.maximum(:place_num).to_i + 1
    else
      #既存のPlace_numを更新する必要がある
      old_place_num = Place.where(post_id: @post_id).where(place_num)
      old_place_num.place_num = old_place_num.place_num + 1

      old_place_num.update()

    end

  end

end
