class AddComponentToPlane < ActiveRecord::Migration
  def change
    PlaneComponent.create!(
      plane: Plane.find(1),
      component: Component.find(1),
      installation_date: '2015-10-10',
      log: 'Dear Diary, today I installed a new engine into my favorite plane. #Soaring'
    )
  end
end
