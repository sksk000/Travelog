class Public::PlacesController < ApplicationController
  def new
     @place = Place.new
    @post_path = params[:post_id]
  end


  def create
    @place = Place.new(place_params)
    @place.post_id = params[:post_id]

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
end
