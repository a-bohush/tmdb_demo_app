class MoviesController < ApplicationController
  def index
    query_params = {
      page: params[:page] || 1,
      include_adult: false,
      language: 'en-US',
      :'primary_release_date.gte'=> 3.years.ago.strftime('%Y-%m-%d')
    }
    movies_query = TheMovieDb.discover_movie_query(query_params)
    query_data = Rails.cache.fetch(query_params.hash) do
      movies_query.data if movies_query.execute
    end

    if query_data
      render locals: {
               movies: query_data.fetch('results').map { |r| Movie.new(r) },
               meta: OpenStruct.new(query_data.slice('page', 'total_pages'))
             }
    else
      head 500
    end
  end

  def show
    query_params = {
      movie_id: params[:id],
      language: 'en-US',
      append_to_response: 'reviews'
    }
    movie_query = TheMovieDb.movie_details_query(query_params)
    query_data = Rails.cache.fetch(query_params.hash) do
      movie_query.data if movie_query.execute
    end
    movie = Movie.new(query_data.except('reviews'))
    reviews_data = query_data.dig('reviews', 'results').to_a

    if query_data
      render locals: {
               movie: movie,
               reviews: reviews_data.map { |d| OpenStruct.new(d) }
             }
    else
      head 500
    end
  end
end
