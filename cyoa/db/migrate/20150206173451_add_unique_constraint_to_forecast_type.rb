class AddUniqueConstraintToForecastType < ActiveRecord::Migration
  def up
    update <<-SQL
      ALTER TABLE forecast_types
      ADD CONSTRAINT unique_forecast_type 
      UNIQUE (forecast_type);
    SQL
  end

  def down
    update <<-SQL
      ALTER TABLE forecast_types
      DROP CONSTRAINT unique_forecast_type
    SQL
  end
end
