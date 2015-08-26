module Helpers
  def generate_group(count, cohort, successes)
    (1..count).map do |i|
      { date: DateTime.now.strftime("%Y-%m-%d"),
        cohort: cohort,
        result: (i <= successes) ? 1 : 0 }
    end
  end

  def generate_data
    group_a = generate_group(87, "A", 5)
    group_b = generate_group(108, "B", 9)
    group_a + group_b
  end
end

RSpec.configure do |c|
  c.include Helpers
end
