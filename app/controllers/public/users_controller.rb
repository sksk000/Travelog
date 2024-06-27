class Public::UsersController < ApplicationController
  before_action :is_matching_login_user
  # マイページ
  def mypage
    @user = current_user
  end

  # マイページ編集
  def edit

  end

  # ユーザ詳細ページ
  def infomation
    @user = current_user
  end

  # ユーザ情報編集
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to mypage_path
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

  private
  def user_params
    params.require(:user).permit(:name, :email, :is_showprofile)
  end

  def is_matching_login_user
    if current_user == nil
      redirect_to new_user_session_path
    end
  end
end
