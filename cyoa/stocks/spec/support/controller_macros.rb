module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user, :with_stocks)
      sign_in user
    end
  end

  def current_user
    user_session_info = response.request.env['rack.session']['warden.user.user.key']
    if user_session_info
      user_id = user_session_info[0][0]
      User.find(user_id)
    else
      nil
    end
  end

  def user_signed_in?
    !!current_user
  end
end