class AddLocationToMeetings < ActiveRecord::Migration
  def change
    add_reference :meetings, :location
  end
end
