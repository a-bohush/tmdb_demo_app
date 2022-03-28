module TheMovieDb
  module Movie
    class Details < TheMovieDb::Query
      def initialize(params={})
        @params = params.symbolize_keys.slice(
          :api_key,
          :movie_id,
          :language,
          :append_to_response
        )
      end

      private

      def url
        "#{TheMovieDb.config.endpoint_base}/movie/#{@params.fetch(:movie_id)}"
      end
    end
  end
end
