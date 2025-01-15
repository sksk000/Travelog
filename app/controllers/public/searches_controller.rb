class Public::SearchesController < ApplicationController
  def search
    @category = params[:search_category_select]
    @searchdata = params[:seachdata] || ''
    @travel_months = params[:travel_months]
    @prefectures = params[:prefectures] || 'all_prefectures'
    @night = params[:night] || 'all_nights'
    @people = params[:people] || 'all_people'
    @post_month = params[:post_months] || []
    @travel_goods = params[:travel_goods] || []

    if @category == "user_search"
      @user =  User.looks(@searchdata)
      @is_empty = @user.empty?
    elsif @category == "post_search"
      @post = Post.looks(params[:seachdata], params[:travel_months], params[:prefectures], params[:night], params[:people], params[:post_months], params[:travel_goods])
      @is_empty = @post.empty?
    end
    render 'result'
  end
end
