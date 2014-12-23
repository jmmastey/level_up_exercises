class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, except: [:new, :create]

  protected

  def after_update_path_for(resource)
    user_path(resource)
  end
end
