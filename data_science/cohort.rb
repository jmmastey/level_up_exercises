class Cohort
  def initialize(data, cohort_name)
    @cohort_name   = cohort_name
    @events = data.select { |event| event['cohort'] == "#{@cohort_name}" }
  end

  def count_events
    @events.each_with_object(Hash.new { |h, k| h[k] = 0 }) do |event, counts|
      counts["#{@cohort_name}_1"]     += 1 if event['result'] == 1
      counts["#{@cohort_name}_0"]     += 1 if event['result'] == 0
      counts["#{@cohort_name}_total"] += 1
    end
  end
end
