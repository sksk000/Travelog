class Admin::UsersController < ApplicationController
  before_action :is_matching_admin_user

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_management_index_path
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def is_matching_admin_user
    if admin_signed_in? == false
     redirect_to new_user_session_path
    end
  end
end
