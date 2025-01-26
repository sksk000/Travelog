class Public::PostsController < ApplicationController
  before_action :is_current_user, only: [:edit, :update, :new]
  def index
    @postall = Post.all
  end

  def show
    @post_id = params[:id]
    target_place_id = params[:place_id]

    @post = Post.find(params[:id])
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
    @post = Post.find(params[:id])
    is_post_user(@post)

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
      createtag(@post) if params[:tag].present?
      createprefecture(@post) if params[:prefecture].present?
      render json: { post: @post, message: '投稿内容登録完了しました、次のページに移動します', redirect_url: new_post_places_path(@post.id) }, status: :created
    else
      render json: { message: "投稿に失敗しました。: #{@post.errors.full_messages.join(', ')}" }, status: :unprocessable_entity
    end
  end

  def update
    @post = Post.find(params[:id])

    is_post_user(@post)

    if @post.update(post_params)
      updatetag(@post) if params[:tag].present?
      updateprefecture(@post) if params[:prefecture].present?
      render json: { redirect_url: edit_post_places_path(@post.id) }
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to mypage_path(@post.user_id)
  end

  def publish
    @post = Post.find(params[:id])
    @post.update(is_release: true)

    redirect_to post_path(@post.id)
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

  def is_post_user(post_data)
    redirect_to mypage_path(current_user.id) if current_user.id != post_data.user.id
  end

  def createtag(post)
    tagnames = tag_params[:name]
    tagnames.each do |tagname|
      tag = Tag.find_or_create_by(name: tagname)
      PostTag.create(post: post, tag: tag) unless post.tags.include?(tag)
    end
  end

  def createprefecture(post)
    prefectures = Array(postprefecture_params[:prefecture])

    prefectures.each do |prefecture|
      prefecture_value = PostPrefecture.prefectures[prefecture]
      PostPrefecture.create(post: post, prefecture: prefecture_value) unless post.post_prefectures.include?(prefecture_value)
    end
  end

  def updatetag(post)
    tagnames = tag_params[:name]
    tagnames.each do |tagname|
      tag = Tag.find_or_create_by(name: tagname)
      post.tags << tag unless post.tags.include?(tag)
    end

    post.tags.where.not(name: tagnames).find_each do |tag|
      post.tags.delete(tag)
    end
  end

  def updateprefecture(post)
    prefectures = Array(postprefecture_params[:prefecture])

    prefectures.each do |prefecture|
      prefecture_value = PostPrefecture.prefectures[prefecture]
      post.post_prefectures.find_or_create_by(prefecture: prefecture_value)
    end

    post.post_prefectures.where.not(prefecture: prefectures).find_each do |post_prefecture|
      post.post_prefectures.delete(post_prefecture)
    end
  end
end
