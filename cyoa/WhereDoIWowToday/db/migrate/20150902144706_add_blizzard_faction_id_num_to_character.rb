class AddBlizzardFactionIdNumToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :blizzard_faction_id_num, :integer, null: false
  end
end
