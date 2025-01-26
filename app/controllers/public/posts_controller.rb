class Public::PostsController < ApplicationController
  before_action :is_current_user, only: [:edit, :update, :new]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :is_post_user, only: [:edit, :update]
  def index
    @postall = Post.all
  end

  def show
    @post_id = params[:id]
    target_place_id = params[:place_id]
    @target_place = @post.getTargetPlace(target_place_id)
    @prefectures = PostPrefecture.where(post_id: params[:id])
    @tags = @post.getTags
    @comments = @post.comments.order(created_at: "DESC")

    respond_to do |format|
      format.html do
        @place = @post.places.order(:place_num)
      end
      format.json do
        @place = @post.places.order(:place_num)
        @target_place_latitude = @target_place.latitude
        @target_place_longitude = @target_place.longitude
      end
    end
  end

  def new
    @post = Post.new
  end

  def edit
    respond_to do |format|
      format.html
      format.json do
        @prefectures = @post.post_prefectures
        @tags = @post.tags
      end
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      TagService.createtag(@post, tag_params[:name]) if params[:tag].present?
      prefectures = Array(postprefecture_params[:prefecture])
      PrefectureService.createprefecture(@post, prefectures) if params[:prefecture].present?
      render json: { post: @post, message: '投稿内容登録完了しました、次のページに移動します', redirect_url: new_post_places_path(@post.id) }, status: :created
    else
      render json: { message: "投稿に失敗しました。: #{@post.errors.full_messages.join(', ')}" }, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      TagService.updatetag(@post, tag_params[:name]) if params[:tag].present?
      prefectures = Array(postprefecture_params[:prefecture])
      PrefectureService.updateprefecture(@post, prefectures) if params[:prefecture].present?
      render json: { redirect_url: edit_post_places_path(@post.id) }
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to mypage_path(@post.user_id)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id, :good, :place, :night, :people, :is_release, :image, :travelmonth)
  end

  def postprefecture_params
    params.require(:prefecture).permit(prefecture: [])
  end

  def tag_params
    params.require(:tag).permit(name: [])
  end

  def is_current_user
    redirect_to new_user_session_path if current_user.nil?
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def is_post_user
    redirect_to mypage_path(current_user.id) if current_user.id != @post.user.id
  end
end
