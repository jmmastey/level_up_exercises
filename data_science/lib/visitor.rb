# => Visitor = Struct.new(:cohort, :visit_date, :result)
require 'date'

class Visitor
  attr_accessor :cohort, :visit_date, :result

  def initialize(params)
    @cohort     = params[:cohort]
    @visit_date = Date.parse(params[:date])
    @result     = params[:result]
  end
end
