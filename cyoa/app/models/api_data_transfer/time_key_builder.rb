require 'active_support/all'

module TimeKeyBuilder
  UNITS = [3, 24]

  def self.time_key(time_layouts)
    time_layouts.each_with_object({}) do |time_layout, final|
      time_layout.start_valid_time.each_with_index do |st, index|
        et = end_time_for_start_time(time_layout, st, index)
        pair = { time_layout.layout_key => index }
        if final.has_key?([st, et])
          final[[st, et]] = final[[st, et]] << pair
        else
          final[[st, et]] = [pair]
        end
      end
    end
  end

  private

  def self.time_unit_end(time_layout, start_valid_time)
    start_valid_time + layout_key_hour_interval(time_layout.layout_key).hours
  end

  def self.end_time_for_start_time(time_layout, start_valid_time, index)
    return time_layout.end_valid_time[index] unless time_layout.end_valid_time.nil?
    start_valid_time + layout_key_hour_interval(time_layout.layout_key).hours
  end

  def self.layout_key_hour_interval(layout_key)
    layout_key.split("-")[1].split("p")[1].split("h")[0].to_i
  end
end