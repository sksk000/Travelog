class Public::MapsController < ApplicationController
  def show
    respond_to do |format|
      format.json do
        @post = Post.last
      end
    end
  end
end
