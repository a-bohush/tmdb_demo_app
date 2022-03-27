module TheMovieDb
  module Movie
    class Details
      attr_reader :result, :error

      def initialize(params={})
        @params = params.symbolize_keys.slice(:api_key, :movie_id)
      end

      def execute
        response = TheMovieDb::HTTP.get(url, @params)
        if response.success?
          @result = response.body
          true
        else
          # TODO: setup error
        end
      end

      private

      def url
        "#{TheMovieDb.config.endpoint_base}/movie/#{@params.fetch(:movie_id)}"
      end
    end
  end
end
