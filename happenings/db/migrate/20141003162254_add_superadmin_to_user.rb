class AddSuperadminToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :superadmin, :boolean, null: false, default: false
    User.create(email: 'admin@example.com', password: 'password',
                 password_confirmation: 'password',
                 superadmin: true)
  end

  def self.down
    remove_column :users, :superadmin
    User.find_by_email('admin@example.com').try(:delete)
  end
end
