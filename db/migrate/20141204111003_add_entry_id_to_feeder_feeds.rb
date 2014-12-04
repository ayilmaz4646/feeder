class AddEntryIdToFeederFeeds < ActiveRecord::Migration
  def change
  	add_column :feeder_feeds, :entry_id, :string
  end
end
