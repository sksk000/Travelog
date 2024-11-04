class Public::SearchesController < ApplicationController
  def search
    @category = params[:search_category_select]

    if @category == "user_search"
      @user =  User.looks(params[:seachdata])
    elsif @category == "post_search"
      @post = Post.looks(params[:seachdata], params[:travelmonth], params[:prefectures], params[:night], params[:people], params[:postmonth], params[:travelgood])
    end

    render 'result'
  end
end
