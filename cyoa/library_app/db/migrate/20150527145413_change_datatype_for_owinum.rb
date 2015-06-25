class ChangeDatatypeForOwinum < ActiveRecord::Migration
  def self.up
    change_table :books do |t|
      t.change :owi_num, :string
    end
  end

  def self.down
    change_table :books do |t|
      t.change :owi_num, :integer
    end
  end
end
