class FavoritesController < ApplicationController
  def show
    params[:id] ||= current_user.id if user_signed_in?

    @favorites = Favorite.includes(:menu_item).where(user_id: params[:id])
  end

  def create
    if user_signed_in?
      menu_item = MenuItem.find_by(id: params[:id])
      Favorite.create(menu_item: menu_item, user: current_user) if menu_item
    end

    redirect_to(:back)
  end

  def destroy
    fave = Favorite.find_by(id: params[:id], user: current_user)
    fave.destroy if fave
    redirect_to(:back)
  end
end
