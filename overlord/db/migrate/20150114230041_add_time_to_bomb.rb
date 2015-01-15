class AddTimeToBomb < ActiveRecord::Migration
  def change
    add_column(:bombs, :activated_time, :datetime)
  end
end
