module TheMovieDb
  module HTTP
    class Response
      def initialize(status_code, body_json)
        @status_code = status_code
        @body_json = body_json
      end

      def success?
        @status_code.to_i == 200
      end

      def body
        @body ||= JSON.parse(@body_json)
      end
    end
  end
end
