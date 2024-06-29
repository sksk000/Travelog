class Public::SearchesController < ApplicationController
  def search
    @category = params[:is_search_category]

    if @category == "User"
      @user =  User.looks(params[:seachdata], params[:is_search_condition])
    else
      @post = Post.looks(params[:seachdata], params[:is_search_condition])
    end

    render 'result'
  end
end
