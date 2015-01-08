
class Cohort
  attr_reader :cohort, :pass, :fail, :total, :conversion_rate, :conversion_range, :standard_error
  def initialize(cohort, pass, fail)
    @cohort = cohort
    @pass = pass
    @fail = fail
    @total = pass + fail
    @conversion_rate = pass.to_f / @total
    @standard_error = sqrt(@conversion_rate * (1 - @conversion_rate) / @total)
    @conversion_range = Range.new(
      @conversion_rate - 1.96 * @standard_error,
      @conversion_rate + 1.96 * @standard_error)
  end
end