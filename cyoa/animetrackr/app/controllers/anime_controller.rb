require 'anime_service'

class AnimeController < ApplicationController
  before_action :authenticate_user!

  def search
    return unless params[:title]

    @title = params[:title].gsub('+', ' ')
    @anime = get_anime(@title)
  end

  def edit
  end

  def remove
  end

  def search_redirect
    redirect_to action: 'search', title: params[:title].gsub(/\s+/, '+')
  end

  private

  def get_anime(title)
    find_anime_from_api(title.downcase)
  end

  def find_anime_from_database(external_id)
    Anime.find_by(external_id: external_id)
  end

  def find_anime_from_api(title)
    AnimeService.new.search(title).each_with_object([]) do |attributes, anime|
      anime << create_anime_if_not_in_database(attributes)
    end
  end

  def create_anime_if_not_in_database(attributes)
    anime = find_anime_from_database(attributes['id'])
    return anime if anime
    create_anime_object(attributes)
  end

  def create_anime_object(attributes)
    Anime.create(
      external_id: attributes['id'],
      status: attributes['status'],
      title: attributes['title'],
      episode_count: attributes['episode_count'],
      episode_length: attributes['episode_length'],
      cover_image: attributes['cover_image'],
      synopsis: attributes['synopsis'],
      show_type: attributes['show_type'],
      community_rating: attributes['community_rating'],
    )
  end
end
