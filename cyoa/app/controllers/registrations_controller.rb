class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    Channel.where(default: true).each do |ch|
      current_user.channels << ch
    end

    '/'
  end
end