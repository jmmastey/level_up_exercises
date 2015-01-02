class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, except: [:new, :create]

  protected

  def after_update_path_for(resource)
    user_path(resource)
  end

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
end
