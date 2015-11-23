class AddPlane1ToPlanes < ActiveRecord::Migration
  def change
    Plane.create!(plane_type: PlaneType.find(1))
  end
end
