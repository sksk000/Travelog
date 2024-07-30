class Public::PlacesController < ApplicationController
  def new
  end


  def create
    session[:place_data] = place_params()
    redirect_to new_post_path
  end

  private
  def place_params
    params.require(:place).permit(:address, :place_name)
  end
end
