class AddUpdatedInfoToForecastTypes < ActiveRecord::Migration
  def up
    update <<-SQL
      ALTER TABLE forecasts
        ADD COLUMN last_refresh_begin_time timestamptz,
        ADD COLUMN last_refresh_end_time timestamptz;
    SQL
  end

  def down
    update <<-SQL
      ALTER TABLE forecasts
        DROP COLUMN last_refresh_begin_time,
        DROP COLUMN last_refresh_end_time;
    SQL
  end
end
