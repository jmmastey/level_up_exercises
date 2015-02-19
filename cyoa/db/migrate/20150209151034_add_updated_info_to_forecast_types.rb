class AddUpdatedInfoToForecastTypes < ActiveRecord::Migration
  def up
    update <<-SQL
      ALTER TABLE forecast_types
        ADD COLUMN last_refresh_start_time timestamptz,
        ADD COLUMN last_refresh_end_time timestamptz;
    SQL
  end

  def down
    update <<-SQL
      ALTER TABLE forecast_types
        DROP COLUMN last_refresh_start_time,
        DROP COLUMN last_refresh_end_time;
    SQL
  end
end
