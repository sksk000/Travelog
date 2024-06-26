class Public::PostsController < ApplicationController
  before_action :is_current_user,only:[:edit, :update, :new]
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id)
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

    is_post_user(@post)

    if @post.update(post_params)
      redirect_to mypage_path
    else
      flash.now[:alert] = @post.errors.full_messages.join(', ')
      render :edit
    end

  end

  def edit
    @post = Post.find(params[:id])
    is_post_user(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to mypage_path
  end

  def show
    @post = Post.find(params[:id])
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end

  def is_current_user
    if current_user == nil
      redirect_to new_user_session_path
    end
  end

  def is_post_user(post_data)
    if current_user != post_data.user
      redirect_to mypage_path
    end
  end
end
