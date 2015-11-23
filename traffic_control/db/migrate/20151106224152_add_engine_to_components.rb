class AddEngineToComponents < ActiveRecord::Migration
  def change
    Component.create!(name: 'Engine')
  end
end
