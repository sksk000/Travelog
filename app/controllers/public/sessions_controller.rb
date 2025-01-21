# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def guest_sign_in
    user = User.guest
    sign_in user
  end

  def after_sign_in_path_for(_resource)
    if warden.user(Admin)
      new_admin_session_path
    elsif warden.user(User)
      posts_path
    else
      root_path
    end
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    email = params[:user][:email]
    if Admin.exists?(email: email)
      resource = Admin.find_by(email: email)
      scope = :admin

    elsif User.exists?(email: email)
      resource = User.find_by(email: email)
      scope = :user

    else
      flash[:alert] = "メールアドレスまたはパスワードが違います、再度入力してください。"
      redirect_to new_user_session_path and return
    end

    if resource.valid_password?(params[:user][:password])
      sign_in(scope, resource)
      flash[:notice] = "ログインに成功しました。"
      redirect_to after_sign_in_path_for(resource)
    else
      flash[:alert] = "メールアドレスまたはパスワードが違います、再度入力してください。"
      redirect_to new_user_session_path and return
    end
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_management_index_path
    elsif resource.is_a?(User)
      posts_path
    else
      root_path
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
