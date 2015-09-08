require 'rails_helper'

describe UsersController do
  it 'redirects to the home page if not logged in' do
    session[user_id: nil]
    get :dashboard
    expect(response).to redirect_to root_path
  end

end
