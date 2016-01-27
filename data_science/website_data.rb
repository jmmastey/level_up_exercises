class WebsiteData
  VISIT = Struct.new(:date, :cohort, :result)
  attr_accessor :visits

  def initialize(array_of_hashes)
    @visits = []
    array_of_hashes.each do |row|
      @visits << VISIT.new(row["date"], row["cohort"], row["result"])
    end
  end

  def filtered_size(filter_hash)
    num_of_matches = 0
    @visits.each do|v|
      num_of_matches += 1 if matches_filter?(v, filter_hash)
    end
    num_of_matches
  end

  private

  def matches_filter?(data, filters)
    cohort_filter = filters.fetch(:cohort, data[:cohort])
    result_filter = filters.fetch(:result, data[:result])
    data[:cohort] == cohort_filter && data[:result] == result_filter
  end
end
