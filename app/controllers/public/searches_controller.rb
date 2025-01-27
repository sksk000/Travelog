class Public::SearchesController < ApplicationController
  def search
    @category = params[:search_category_select]
    @searchdata = search_params[:seachdata]

    case @category
    when "user_search"
      @results = User.looks(search_params[:searchdata])
    when "post_search"
      @results = Post.looks(search_params)
    end

    @is_empty = @results.empty?

    @stay_nights = search_params[:stay_nights]
    @people =  search_params[:people]
    @post_month = search_params[:post_months]
    @travel_goods = search_params[:travel_goods]
    @travel_months = search_params[:travel_months]
    @prefectures = search_params[:prefectures]
    render 'result'

  end

  private

  def search_params
    {
      searchdata: params[:seachdata] || '',
      travel_months: params[:travel_months],
      prefectures: params[:prefectures],
      stay_nights: params[:stay_nights],
      people: params[:people],
      post_months: params[:post_months] || nil,
      travel_goods: params[:travel_goods] || nil,
    }
  end
end
