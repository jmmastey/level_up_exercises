class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  before_action { @menu_items = [] }
  before_action :authenticate_user!

  attr_reader :menu_items

  def add_menu_item(link_name, uri)
    @menu_items << { link_name: link_name, uri: uri }
  end
end
