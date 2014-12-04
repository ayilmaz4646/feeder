class AddIndexesToFeederFeeds < ActiveRecord::Migration
  def change
  	add_index :feeder_feeds, [:entry_id, :feed_source_id], unique: true
  end
end
