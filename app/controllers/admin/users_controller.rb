class Admin::UsersController < ApplicationController
  def index
    @userall = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  def show
    @user = User.find(params[:id])
  end
end
