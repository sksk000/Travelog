class Public::PostsController < ApplicationController
  before_action :is_current_user,only:[:edit, :update, :new]
  before_action :is_visility, only:[:show]
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      createtag(@post, params[:tag]) if params[:tag].present?
      createprefecture(@post, params[:prefecture]) if params[:prefecture].present?
      render json: { post: @post, message: '投稿が成功しました', redirect_url: new_post_places_path(@post.id) }, status: :created
    else
      render json: { error: '投稿に失敗しました', details: @post.errors.full_messages }, status: :unprocessable_entity
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
    @post_id = params[:id]
    target_place_id = params[:place_id]

    @post = Post.find(params[:id])
    if target_place_id
      @target_place = @post.places.find(target_place_id)
    else
      @target_place = @post.places.first
    end
    @prefectures = PostPrefecture.where(post_id: params[:id])
    post_tags = PostTag.where(post_id: params[:id])
    tag_ids = post_tags.pluck(:tag_id)
    @tags = Tag.where(id: tag_ids)


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
    params.require(:post).permit(:title, :body, :user_id, :good, :place, :night, :people,:is_release, :image, :travelmonth)
  end

  def postprefecture_params
    params.require(:prefecture).permit(prefecture:[])
  end

  def tag_params
    params.require(:tag).permit(name:[])
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

  def createtag(post, tagnames)
    tagnames = tag_params[:name]
    tagnames.each do |tagname|
      tag = Tag.find_or_create_by(name: tagname)
      PostTag.create(post: post, tag: tag) unless post.tags.include?(tag)
    end
  end

  def createprefecture(post, prefectures)
    prefectures = Array(postprefecture_params[:prefecture])

    prefectures.each do |prefecture|
      prefecture_value = PostPrefecture.prefectures[prefecture]
      PostPrefecture.create(post: post, prefecture: prefecture_value) unless post.post_prefectures.include?(prefecture_value)
    end
  end
end
