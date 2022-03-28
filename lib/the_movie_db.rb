require 'ostruct'
require 'the_movie_db/http'
require 'the_movie_db/query'
require 'the_movie_db/discover/movie'
require 'the_movie_db/movie/details'

module TheMovieDb
  class << self
    def config
      @config ||= OpenStruct.new(
        api_key: nil,
        endpoint_base: 'https://api.themoviedb.org/3',
        images_base: 'https://image.tmdb.org/t/p/'
      )
    end

    def configure
      yield(config)
    end

    def discover_movie_query(params={})
      TheMovieDb::Discover::Movie.new(prepare_params(params))
    end

    def movie_details_query(params={})
      TheMovieDb::Movie::Details.new(prepare_params(params))
    end

    def image_url(path:, size:)
      "#{config.images_base}#{size}/#{path}"
    end

    private

    def default_params
      { api_key: config.api_key }
    end

    def prepare_params(params)
      default_params.merge(params.symbolize_keys)
    end
  end
end
