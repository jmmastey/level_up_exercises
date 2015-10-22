require 'json'
require 'set'

class UsersController < ApplicationController
  before_action :logged_in_user,  only: [:edit, :update]
  before_action :correct_user,    only: [:edit, :update]
  skip_before_action :verify_authenticity_token, :only => [:save_favorite, :remove_favorite]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "Thanks for creating a MyCTApp account!"
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def save_favorite
    if logged_in?
      route = build_route_from_data(params)
      @user = User.find(session[:user_id])
      if @user.favorite_add(route)
        return render Response.Json(:ok, "Route favorited.", favorite_routes: @user.favorite_route_list)
      else
        return render Response.Json(:error, "Unable to favorite route.")
      end
    end
    return render Response.Json(:error, "Unable to favorite route.")
  end

  def remove_favorite
    if logged_in?
      route = build_route_from_data(params)
      @user = User.find(session[:user_id])
      if @user.favorite_remove(route)
        return render Response.Json(:ok, "Route Removed.", favorite_routes: @user.favorite_route_list)
      else
        return render Response.Json(:error, "Unable to remove favorite route.")
      end
    end
    render Response.Json(:error, "Unable to remove favorite route.")
  end

  def favorite_routes
    if logged_in?
      @user = User.find(session[:user_id])
      puts "WANTS FAVORITE ROUTES"
      routes = @user.favorite_route_list
      return render Response.Json(:ok, "", favorite_routes: routes)
      # favorite_routes = []
      #
      # unless @user.favorite_routes.nil?
      #   favorite_routes = @user.favorite_routes
      # end
      #
      # if favorite_routes.length != 0
      #   favorite_routes = JSON.parse(favorite_routes)
      # end
      # render json: { status: :ok, favorite_routes: favorite_routes }
    end
    return render Response.Json(:error, "Unable to complete request.")
  end

  def recent_routes
    if logged_in?
      render json: { status: :ok, recent_routes: user_recent_routes }
    else
      render json: { status: :error }
    end
  end


  private

  def build_route_from_data(data)
    route = {
      number: data[:number],
      direction: data[:direction],
      stop_id: data[:stop][:stop_id],
      stop_name: data[:stop][:stop_name],
    }
  end

  def user_favorite_routes
    @user = User.find(session[:user_id])
    return [] if @user.favorite_routes.nil?
    JSON.parse(@user.favorite_routes)
  end

  def user_recent_routes
    @user = User.find(session[:user_id])
    return "[]" if @user.recent_routes.nil?
    @user.recent_routes
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # confirms logged in user
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # confirms correct user
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
