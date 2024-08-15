class Public::PostsController < ApplicationController
  before_action :is_current_user,only:[:edit, :update, :new]
  before_action :is_visility, only:[:show]
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to new_post_places_path(@post.id)
    else
      flash.now[:alert] = @post.errors.full_messages.join(', ')
      render :new
    end

  end

  def index
    @postall = Post.all
  end

  def new
    @post = Post.new
  end

  def update
    @post = Post.find(params[:id])

    is_post_user(@post)

    if @post.update(post_params)
      redirect_to edit_post_places_path(@post.id)
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
    redirect_to mypage_path(@post.user_id)
  end

  def show

   target_place_id = params[:place_id]

   @post = Post.find(params[:id])
   if target_place_id
    @target_place = @post.places.find(target_place_id)
   else
    @target_place = @post.places.first
   end

    respond_to do |format|
      format.html do
        @post = Post.find(params[:id])
        @place = @post.places.order(:place_num)
      end
      format.json do
        @post = Post.find(params[:id])
        @place = @post.places.order(:place_num)
        @target_place_latitude = @target_place.latitude
        @target_place_longitude = @target_place.longitude
      end
    end
  end

  def publish
    @post = Post.find(params[:id])
    @post.update(is_release: true)

    redirect_to post_path(@post.id)
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :user_id, :good)
  end

  def is_current_user
    if current_user == nil
      redirect_to new_user_session_path
    end
  end

  def is_post_user(post_data)
    if current_user.id != post_data.user.id
      redirect_to mypage_path(current_user.id)
    end
  end

  def is_visility
    post = Post.find(params[:id])
    if post.is_release == false and current_user.id != post.user_id
      redirect_to mypage_path(post.user_id)
    end
  end
end
