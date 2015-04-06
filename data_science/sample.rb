class Sample
  attr_accessor :date, :cohort, :result

  def initialize(row)
    @date = row['date']
    @cohort = row['cohort']
    @result = row['result']
  end
end
