class ChangeLegislatorAttributes < ActiveRecord::Migration
  def change
    remove_column :legislators, :fec_id, :string
    remove_column :legislators, :congresspedia_url, :string
    remove_column :legislators, :official_rss, :string
    remove_column :legislators, :senate_class, :string
    remove_column :legislators, :in_office, :integer

    add_column :legislators, :term_start, :string
    add_column :legislators, :term_end, :string
    add_column :legislators, :leadership_role, :string
    add_column :legislators, :in_office, :boolean

    rename_column :legislators, :firstname, :first_name
    rename_column :legislators, :middlename, :middle_name
    rename_column :legislators, :lastname, :last_name
    rename_column :legislators, :birthdate, :birthday
    rename_column :legislators, :webform, :contact_form
    rename_column :legislators, :congress_office, :office
    rename_column :legislators, :youtube_url, :youtube_id
  end
end
