class Public::SearchesController < ApplicationController
  def search
    @category = params[:is_search_category]

    if @category == "User"
      @user =  User.looks(params[:seachdata], params[:is_search_condition])
    elsif @category == "Post"
      @post = Post.looks(params[:seachdata], params[:is_search_condition], params[:is_search_season], params[:is_search_place], params[:is_search_night], params[:is_search_people])
    end

    render 'result'
  end
end
