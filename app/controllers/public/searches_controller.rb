class Public::SearchesController < ApplicationController
  def search
    @category = params[:is_search_category]

    if @category == "User"
      @user =  User.find_by(name: params[:seachdata])
    else
      @post = Post.where(title: params[:seachdata])
    end

    render 'result'
  end
end
