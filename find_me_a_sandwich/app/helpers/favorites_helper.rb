module FavoritesHelper
  def favorite_link(item)
    if item.favorite
      link_to("remove from favorites", "/favorites/destroy/#{item.favorite.id}")
    else
      link_to("save to favorites", "/favorites/new/#{item.id}")
    end
  end
end
