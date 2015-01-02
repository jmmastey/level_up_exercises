class ChangeBirthdayToBirthyearToArtists < ActiveRecord::Migration
  def up
    remove_column :artists, :birthday, :date
    add_column :artists, :birthyear, :string
  end

  def down
    remove_column :artists, :birthyear, :string
    add_column :artists, :birthday, :date
  end
end
