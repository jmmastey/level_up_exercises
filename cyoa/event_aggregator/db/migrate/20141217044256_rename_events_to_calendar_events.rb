class RenameEventsToCalendarEvents < ActiveRecord::Migration
  def change
    rename_table :events, :calendar_events
  end
end
