class WebsiteData
  VISIT = Struct.new(:date, :cohort, :result)
  attr_accessor :visits

  def initialize(array_of_hashes)
    @visits = array_of_hashes.map do |row|
      VISIT.new(row["date"], row["cohort"], row["result"])
    end
  end

  def filtered_size(filter_hash)
    @visits.count { |v| matches_filter?(v, filter_hash) }
  end

  private

  def matches_filter?(data, filters)
    cohort_filter = filters.fetch(:cohort, data[:cohort])
    result_filter = filters.fetch(:result, data[:result])
    data[:cohort] == cohort_filter && data[:result] == result_filter
  end
end
