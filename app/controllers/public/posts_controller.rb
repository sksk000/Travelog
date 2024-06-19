class Public::PostsController < ApplicationController
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to mypage_path
    else
      flash.now[:alert] = @post.errors.full_messages.join(', ')
      render :new
    end
  end

  def index
  end

  def new
    @post = Post.new
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to mypage_path
    else
      flash.now[:alert] = @post.errors.full_messages.join(', ')
      render :edit
    end

  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
  end

  def show
    @post = Post.find(params[:id])
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
end
