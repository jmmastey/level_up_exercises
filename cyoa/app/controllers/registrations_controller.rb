class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password, :password_confirmation, :biography)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password, :password_confirmation, :biography, :current_password)
  end
end
