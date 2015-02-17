class FavoritesController < ApplicationController
  def create
    @favorite = current_user.favorites.build(user_id: current_user.id,
      legislator_id: legislator_id)
    if @favorite.save
      flash[:success] = "Legislator added to favorites!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @favorite = current_user.favorites.find_by(id: params[:id])
    @favorite.destroy
    flash[:success] = "Favorite deleted"
    redirect_to request.referrer || root_url
  end
end
