class Admin::PostsController < ApplicationController
  def index
    @post = Post.all
  end

  def show
    @post = Post.find(params[:id]);
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_management_index_path
  end
end
