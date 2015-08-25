class AnimeLibraryController < ApplicationController
  before_action :authenticate_user!

  def index
    @library = LibraryItem.where(user: current_user)
    @user = current_user
  end

  def view
    @user = User.find_by(username: params[:username])
    @library = LibraryItem.where(user: @user)
    render :index
  end

  def add
    @library_item = LibraryItem.new
    @library_item.anime = Anime.find(params[:id])
    @library_item.user = current_user
  end

  def create
    library_item = LibraryItem.new(library_item_params)
    library_item.anime_id = params[:id]
    library_item.user = current_user
    library_item.save
    redirect_to(profile_path)
  end

  def edit
    @library_item = get_library_item(params[:id])
  end

  def submit_edit
    library_item = get_library_item(params[:id])
    library_item.update(library_item_params)

    redirect_to(profile_path)
  end

  def remove
    library_item = get_library_item(params[:id])
    library_item.destroy
    redirect_to(profile_path)
  end

  private

  def library_item_params
    params.require(:library_item).permit(:user_rating, :view_status, :public)
  end

  def get_library_item(id)
    LibraryItem.find_by(user: current_user, id: id)
  end
end
