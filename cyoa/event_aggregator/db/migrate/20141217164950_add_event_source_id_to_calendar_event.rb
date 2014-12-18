class AddEventSourceIdToCalendarEvent < ActiveRecord::Migration
  def change
    change_table :calendar_events do |t|
      t.belongs_to :event_source
    end  
  end
end
