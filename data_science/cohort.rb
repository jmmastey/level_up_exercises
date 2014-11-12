class Cohort
  attr_accessor :size, :conversions, :failures, :conversion_percentage,
    :group_name

  def initialize(cohort_visits)
    @size = cohort_visits.length
    @conversions = cohort_conversions(cohort_visits)
    @failures = @size - @conversions
    @conversion_percentage = conversion_percentage
    @group_name = cohort_visits.first["cohort"]
  end

  def conversion_percentage
    (conversion_rate * 100).round(2)
  end

  private

  def conversion_rate
    conversions.to_f / size.to_f
  end

  def cohort_conversions(cohort_visits)
    cohort_visits.inject(0) { |result, visit| result + visit['result'] }
  end
end
