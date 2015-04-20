module ClimateHelper

  def self.day_array
    days = []
    (0..6).each do |i|
      if (Time.now.wday + i) > 6
        days[i] = Date::DAYNAMES[Time.now.wday + i - 7]
      else
        days[i] = Date::DAYNAMES[Time.now.wday + i]
      end
    end
    days
  end
end
