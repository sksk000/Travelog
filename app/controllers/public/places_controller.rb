class Public::PlacesController < ApplicationController
  def new
  end


  def create
    @place = Place.new(place_params)

    if @place.save
      @post = Post.new
      @post.places << @place

      redirect_to new_post_path
    end


  end

  private
  def place_params
    params.require(:place).permit(:address, :name)
  end
end
