class Location
  DEFAULT_ZIP_CODE = 60606
  DEFAULT_STATION_ID = "KMDW"

  def self.zip_codes
    User.uniq.pluck(:zip_code) | [DEFAULT_ZIP_CODE]
  end

  def self.stations
    User.uniq.pluck(:station_id) | [DEFAULT_STATION_ID]
  end
end
