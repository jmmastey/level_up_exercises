class TimeLayoutParameter
  attr_reader :layout_key,
              :start_valid_time,
              :end_valid_time

  def initialize(time_layout)
    @layout_key = time_layout[:layout_key]
    @start_valid_time = time_layout[:start_valid_time]
    @end_valid_time = time_layout[:end_valid_time]
  end
end
