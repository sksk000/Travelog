# frozen_string_literal: true

class Public::RegistrationsController < Devise::RegistrationsController
  #before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    user = build_resource(sign_up_params)
    if user.save
      sign_in(user)
      redirect_to posts_path, notice: '登録に成功しました。'
    else
      redirect_to new_user_registration_path, alert: '登録に失敗しました。'
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    if update_resource(current_user, user_params)
      render json: { message: 'ユーザー情報が更新されました' }, status: :ok
    else
      render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :is_showprofile, :introduction, :profile_image, :email, :password, :password_confirmation, :current_password)
  end

  def sign_up_params
    params.require(:user).permit(:name,:email, :password, :password_confirmation)
  end

  def update_resource(resource, params)
    if params[:password].present? && params[:password_confirmation].present?
      resource.update_with_password(params)
    else
      resource.update_without_password(params.except(:current_password, :password, :password_confirmation))
    end
  end


  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :is_showprofile, :introduction, :profile_image, :password, :password_confirmation])
  end

  # The path used after sign up.
  #def after_sign_up_path_for(resource)
  #
  #end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
