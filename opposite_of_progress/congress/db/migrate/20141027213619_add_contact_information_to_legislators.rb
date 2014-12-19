# Add contact information to legislators
class AddContactInformationToLegislators < ActiveRecord::Migration
  def change
    add_column :legislators, :phone, :string
    add_column :legislators, :website, :string
    add_column :legislators, :office, :string
    add_column :legislators, :contact_form, :string
  end
end
