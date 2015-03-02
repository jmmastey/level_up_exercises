class Cohort
  attr_accessor :name, :result, :date

  def initialize(row)
    @date = row['date']
    @name = row['cohort']
    @result = row['result']
  end
end
