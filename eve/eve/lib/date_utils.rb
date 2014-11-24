module DateUtils
  def self.get_date_occurrence_before(max_date, month, day)
    year = max_date.year
    begin
      DateTime.new(year, month, day)
    rescue
      DateTime.new(year - 1, month, day)
    end
  end
end
