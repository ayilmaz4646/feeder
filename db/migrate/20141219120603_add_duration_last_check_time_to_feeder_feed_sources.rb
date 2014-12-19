class AddDurationLastCheckTimeToFeederFeedSources < ActiveRecord::Migration
  def change
  	add_column :feeder_feed_sources, :duration, :string
  	add_column :feeder_feed_sources, :last_check_time, :string
  end
end
