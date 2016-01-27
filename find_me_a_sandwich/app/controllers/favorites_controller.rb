class FavoritesController < ApplicationController
  def show
    params[:id] ||= current_user.id
    @favorites = Favorite.where(user_id: params[:id])
  end

  def new
    menu_item = MenuItem.find_by(id: params[:id])
    Favorite.create(menu_item: menu_item, user: current_user)
    redirect_to(:back)
  end

  def destroy
    Favorite.destroy(params[:id])
    redirect_to(:back)
  end
end
