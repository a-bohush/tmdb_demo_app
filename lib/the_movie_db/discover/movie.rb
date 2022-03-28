module TheMovieDb
  module Discover
    class Movie < TheMovieDb::Query
      def initialize(params={})
        @params = params.symbolize_keys.slice(
          :api_key,
          :page,
          :include_adult,
          :language,
          :'primary_release_date.gte'
        )
      end

      private

      def url
        "#{TheMovieDb.config.endpoint_base}/discover/movie"
      end
    end
  end
end
