module AnimeLibraryHelper
  include ProfileHelper
  def ratings_options
    (0..5).each_with_object([]) { |i, ratings| ratings << [i, i] }
  end
end
