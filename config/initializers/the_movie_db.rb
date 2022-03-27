require 'the_movie_db'

TheMovieDb.configure do |config|
  config.api_key = ENV.fetch('THE_MOVIE_DB_API_KEY')
end
