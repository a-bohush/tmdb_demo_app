module TheMovieDb
  module Discover
    class Movie
      attr_reader :results, :page, :total_pages, :error

      def initialize(params={})
        @params = params.symbolize_keys.slice(
          :api_key,
          :page,
          :include_adult,
          :language,
          :'primary_release_date.gte'
        )
      end

      def execute
        response = TheMovieDb::HTTP.get(url, @params)
        if response.success?
          @results = response.body.fetch('results')
          @page = response.body.fetch('page')
          @total_pages = response.body.fetch('total_pages')
          true
        else
          # TODO: setup error
        end
      end

      private

      def url
        "#{TheMovieDb.config.endpoint_base}/discover/movie"
      end
    end
  end
end
