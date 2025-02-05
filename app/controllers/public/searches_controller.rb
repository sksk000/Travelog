class Public::SearchesController < ApplicationController
  def search
    @category = params[:search_category_select]
    @searchdata = search_params[:searchdata]

    case @category
    when "user_search"
      @results = User.looks(search_params[:searchdata])
    when "post_search"
      @results = Post.looks(search_params)
    when "tag_search"
      @results = Tag.looks(search_params[:searchdata])
    end

    @is_empty = @results.blank?

    @stay_nights = search_params[:stay_nights]
    @people = search_params[:people]
    @post_month = search_params[:post_months]
    @travel_goods = search_params[:travel_goods]
    @travel_months = search_params[:travel_months]
    @prefectures = search_params[:prefectures]
    render 'result'
  end

  private

  def search_params
    params.permit(:searchdata, :travel_months, :prefectures, :stay_nights, :people, :post_months, :travel_goods)
  end
end
