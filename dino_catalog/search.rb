module Search
  def find(keyword)
    result = @store.find { |x| x.fetch(:name) == keyword }
    print_one(result)
  end

  def select(category, keyword)
    results = @dinosaurs.find_all { |x| x.fetch(category.to_sym) == keyword }
    tp results
  end
end
