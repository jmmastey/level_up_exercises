namespace :movie do
  desc "TODO"
  MY_API_KEY = '7f052176a77b44b47431f908b840ace8'
  task update: :environment do
    records = get_movies['results']
    records.each do |record|
      movie = Movie.new
      movie.name = record['title']
      movie.release_date = record['release_date']
      movie.poster_path = build_image_path << record['poster_path']
      movie.save
    end
  end

  def get_movies
    url = 'http://api.themoviedb.org/3/movie/popular?api_key=' << MY_API_KEY
    uri = URI(url)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
  end

  def image_configuration
    url = 'http://api.themoviedb.org/3/configuration?api_key=' << MY_API_KEY
    uri = URI(url)
    image_config = Net::HTTP.get_response(uri)
    JSON.parse(image_config.body) if image_config.is_a?(Net::HTTPSuccess)
  end

  def build_image_path
    image_info = image_configuration['images']
    image_info['base_url'] << image_info['poster_sizes'][4]
  end
end