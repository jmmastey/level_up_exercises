class CreateSelectionCriteria < ActiveRecord::Migration
  def change
    create_table :selection_criteria do |t|
      t.string :implementation_class
      t.text :configuration
      t.string :sql_expression

      t.timestamps
    end
  end
end
