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
    render 'result'

  end

  private

  def search_params
    {
      searchdata: params[:seachdata] || '',
      travel_months: params[:travel_months],
      prefectures: params[:prefectures],
      night: params[:night],
      people: params[:people],
      post_month: params[:post_months] || nil,
      travel_goods: params[:travel_goods] || nil,
    }
  end
end
