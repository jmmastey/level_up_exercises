class CreateFeedsSelectionCriteria < ActiveRecord::Migration
  def change
    create_table :feeds_selection_criteria, id: false do |t|
      t.integer :feed_id
      t.integer :selection_criterion_id
    end
  end
end
