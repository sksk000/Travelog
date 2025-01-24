class Public::UsersController < ApplicationController
  before_action :is_matching_login_user
  before_action :ensure_guest_user, only: [:edit, :infomation]
  # マイページ
  def mypage
    @user = User.find(params[:id])
    @posts = @user.posts

    redirect_to mypage_path(current_user.id) unless @user.is_showprofile == true || @user.id == current_user.id
  end

  def edit
    @user = User.find(params[:id])

    image_url = url_for(@user.profile_image) if @user.profile_image.attached?

    respond_to do |format|
      format.html
      format.json do
        render json: { image_url: image_url }
      end
    end
  end

  # ユーザ退会
  def withdraw
    @user = current_user
    if @user.destroy
      render json: { message: '投稿が成功しました', redirect_url: root_path }, status: :ok
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def mypage_place
    @user = User.find(params[:id])
    respond_to do |format|
      format.html do
        @user = User.find(params[:id])
      end
      format.json do
        @user = User.find(params[:id])
      end
    end
  end

  def post_index
    @user = User.find(params[:id])
    @posts = @user.getOrderUserPostData(params[:select])

    render partial: 'public/posts/index', layout: false, locals: { targetpost: @posts, userdata: @user }
  end

  private

  def is_matching_login_user
    redirect_to new_user_session_path if current_user.nil?
  end

  def ensure_guest_user
    @user = current_user
    redirect_to mypage_path(current_user), notice: "ゲストユーザーは遷移できません。" if @user.email == "guest@example.com"
  end
end
