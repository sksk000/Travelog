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
  end

  # ユーザ退会
  def withdraw
  end

end
