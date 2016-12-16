class ChangeInOfficeFieldForLegislators < ActiveRecord::Migration
  def self.up
    remove_column :legislators, :in_office
    add_column :legislators, :in_office, :integer
  end

  def self.down
    remove_column :legislators, :in_office
    add_column :legislators, :in_office, :string
  end
end
