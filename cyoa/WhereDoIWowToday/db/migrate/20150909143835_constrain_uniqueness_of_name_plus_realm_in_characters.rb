class ConstrainUniquenessOfNamePlusRealmInCharacters < ActiveRecord::Migration
  def up
    execute <<-SQL
      alter table characters
        add constraint name_and_realm unique (name, realm);
    SQL
  end

  def down
    execute <<-SQL
      alter table characters
        drop constraint if exists name_and_realm unique;
    SQL
  end
end
