module UsersHelper

  def current_user?
    current_user == @user
  end

  def account_type
    if @user.admin?
      "Administrator"
    else
      "Basic"
    end
  end

  def sample_artwork_image(artist)
    if artist.artworks.any?
      image_tag(artist.artworks.first.thumbnail)
    end
  end
end
