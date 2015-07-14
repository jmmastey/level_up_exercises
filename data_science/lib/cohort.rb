class Cohort
  attr_accessor :date, :name, :result

  def initialize(args = {})
    @date = args['date'] unless args['date'].nil?
    @name = args['cohort'] unless args['cohort'].nil?
    @result = args['result'] unless args['result'].nil?
  end

  def conversion?
    result == 1
  end
end
