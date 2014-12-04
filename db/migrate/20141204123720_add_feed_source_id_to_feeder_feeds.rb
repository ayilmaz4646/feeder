class AddFeedSourceIdToFeederFeeds < ActiveRecord::Migration
  def change
  	add_column :feeder_feeds, :feed_source_id, :integer
  end
end
