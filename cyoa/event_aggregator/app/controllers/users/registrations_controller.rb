class Users::RegistrationsController < Devise::RegistrationsController
  layout 'login'

  # NOTE: For more methods that one can define, refer to original controller
  # template code in the devise gem from which this was made by duplication by
  # rails generate

  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]

  protected

  USER_ACCESSORY_FIELDS = [:first_name, :last_name]

  # You can put the params you want to permit in the empty array.
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up).push(*USER_ACCESSORY_FIELDS)
  end

  # You can put the params you want to permit in the empty array.
  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update).push(*USER_ACCESSORY_FIELDS)
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    root_path
  end
end
