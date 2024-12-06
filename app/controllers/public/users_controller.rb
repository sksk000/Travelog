class Public::UsersController < ApplicationController
  before_action :is_matching_login_user
  before_action :ensure_guest_user, only: [:edit,:infomation]
  # マイページ
  def mypage
    @user = User.find(params[:id])
    @posts = @user.posts

    unless @user.is_showprofile == true || @user.id == current_user.id
      redirect_to mypage_path(current_user.id)
    end

  end

  # マイページ編集
  def edit
    @user = User.find(params[:id])
  end

  # ユーザ詳細ページ
  def infomation
    @user = current_user
  end

  # ユーザ情報編集
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to mypage_path(@user.id)
    else
      flash.now[:alert] = @user.errors.full_messages.join(', ')
      render :infomation
    end

  end

  # ユーザ退会
  def withdraw
    @user = current_user
    @user.destroy
    redirect_to root_path
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

    byebug

    @posts = case params[:select]
     when 'newpost'
       @user.posts.order(created_at: :desc)
     when 'comment'
       @user.posts.left_joins(:comments).group(:id).order('COUNT(comments.id) DESC')
     else
       @user.posts
     end

    render partial: 'public/posts/index', layout: false, locals: { targetpost: @posts, userdata: @user }
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :is_showprofile,:introduction, :profile_image)
  end

  def is_matching_login_user
    if current_user == nil
      redirect_to new_user_session_path
    end
  end

   def ensure_guest_user
    @user = current_user
    if @user.email == "guest@example.com"
      redirect_to mypage_path(current_user) , notice: "ゲストユーザーは遷移できません。"
    end
  end
end
