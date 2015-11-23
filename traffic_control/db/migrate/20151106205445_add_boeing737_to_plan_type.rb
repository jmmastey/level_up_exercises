class AddBoeing737ToPlanType < ActiveRecord::Migration
  def change
    PlaneType.create!(name: 'Boeing 737', seat_count: 143)
  end
end
