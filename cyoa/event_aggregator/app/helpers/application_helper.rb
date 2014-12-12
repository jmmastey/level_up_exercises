module ApplicationHelper
   # Gets the actual resource stored in the instance variable
  def resource
    @user ||= User.new
  end

  # Proxy to devise map name
  def resource_name
    :user
  end

  # Attempt to find the mapped route for devise based on request path
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
