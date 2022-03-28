module TheMovieDb
  class Query
    attr_reader :data, :error

    def execute
      response = TheMovieDb::HTTP.get(url, @params)
      if response.success?
        @data = response.body
        true
      else
        # TODO: setup error
      end
    end

    private

    def base_url
      TheMovieDb.config.endpoint_base
    end
  end
end
