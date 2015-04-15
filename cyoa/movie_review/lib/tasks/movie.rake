namespace :movie do
  desc "TODO"
  task update: :environment do
    records = get_movies['Search']
    records.each do |record|
      movie = Movie.new
      movie.name = record['Title']
      movie.year = record['Year'].to_i
      movie.save
    end
  end
  def get_movies
      uri = URI('http://www.omdbapi.com/?s=*a*&y=2014&plot=full&r=json')
      response = Net::HTTP.get_response(uri)
      JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
  end
end