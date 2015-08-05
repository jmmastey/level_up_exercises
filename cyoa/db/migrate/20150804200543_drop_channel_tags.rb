class DropChannelTags < ActiveRecord::Migration
  def change
    drop_table :channel_tags
  end
end
