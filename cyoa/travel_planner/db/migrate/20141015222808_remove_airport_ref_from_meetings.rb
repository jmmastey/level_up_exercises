class RemoveAirportRefFromMeetings < ActiveRecord::Migration
  def change
    remove_reference :meetings, :airport
  end
end
