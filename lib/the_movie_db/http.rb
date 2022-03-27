require 'net/http'
require 'the_movie_db/http/response'

module TheMovieDb
  module HTTP
    def self.get(url, params)
      uri = URI(url)
      uri.query = URI.encode_www_form(params)
      response = Net::HTTP.get_response(uri)
      TheMovieDb::HTTP::Response.new(response.code, response.body)
    end
  end
end
