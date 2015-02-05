require 'active_support/all'

module TimeKeyBuilder
  def self.times(time_layouts)
    time_layouts.each_with_object({}) do |time_layout, final|
      time_layout.start_valid_time.each_with_index do |st, index|
        tk = time_key(time_layout, st, index)
        pair = { time_layout.layout_key => index }
        if tk[0].class == Array
          tk.each do |k|
            final = add_value_pair(k, pair, final)
          end
        else
          final = add_value_pair(tk, pair, final)
        end
      end
    end
  end

  private

  def self.add_value_pair(tk, pair, final)
    if final.has_key?(tk)
      final[tk] = final[tk] << pair
    else
      final[tk] = [pair]
    end
    final
  end

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

  def self.forecast_type_key
    key = {}
    id_3 = 1 #ForecastType.where(forecast_type: "3-hour").first[:id]
    id_24 = 2 #ForecastType.where(forecast_type: "24-hour").first[:id]
    { 1 => id_3, 3 => id_3, 24 => id_24 }
  end

  def self.layout_key_is_literal(layout_key)
    i = layout_key_hour_interval(layout_key)
    i != 24
  end

  def self.layout_key_forecast_type(layout_key)
    forecast_type_key[layout_key_hour_interval(layout_key)]
  end

  def self.start_time_for_24_hour_start(start_time)
    start_time.beginning_of_day
  end

  def self.end_time_for_24_hour_start(start_time)
    start_time.end_of_day
  end

  def self.start_time_for_24_hour_end(end_time)
    end_time.beginning_of_day
  end

  def self.end_time_for_24_hour_end(end_time)
    end_time.end_of_day
  end

  def self.time_key(time_layout, st, index)
    lk = time_layout.layout_key
    id = layout_key_forecast_type(lk)
    et = end_time_for_start_time(time_layout, st, index)
    if layout_key_is_literal(lk)
      [id, st, et]
    else
      st_1 = start_time_for_24_hour_start(st)
      et_1 = end_time_for_24_hour_start(st)
      st_2 = start_time_for_24_hour_end(et)
      et_2 = end_time_for_24_hour_end(et)
      return [id, st_1, et_1] unless st_1 != st_2
      [[id, st_1, et_1],[id, st_2, et_2]]
    end
  end
end
