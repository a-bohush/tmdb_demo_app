class Movie < SimpleDelegator
  def initialize(attributes)
    __setobj__(OpenStruct.new(attributes))
  end

  def poster_url(size:)
    TheMovieDb.image_url(path: poster_path, size: size)
  end

  def genres
    @genres ||= __getobj__.genres.map { |g| OpenStruct.new(g) }
  end

  def release_year
    Date.parse(release_date).year
  end
end
