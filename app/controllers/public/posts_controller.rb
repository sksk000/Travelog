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
  end

  def edit
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
