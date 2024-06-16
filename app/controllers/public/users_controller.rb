class Public::UsersController < ApplicationController

  # マイページ
  def mypage
    @user = current_user
  end

  # マイページ編集
  def edit

  end

  # ユーザ詳細ページ
  def show
  end

  # ユーザ情報編集
  def update
    @user = current_user
  end

  # ユーザ退会
  def withdraw
    @user = current_user
    @user.destroy
  end

end
