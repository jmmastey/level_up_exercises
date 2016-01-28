class FavoritesController < ApplicationController
  def show
    params[:id] ||= current_user.id if user_signed_in?

    @favorites = Favorite.where(user_id: params[:id])
  end

  def new
    menu_item = MenuItem.find_by(id: params[:id])
    Favorite.create(menu_item: menu_item, user: current_user) if menu_item
    redirect_to(:back)
  end

  def destroy
    Favorite.destroy(params[:id]) if params[:id]
    redirect_to(:back)
  end
end
