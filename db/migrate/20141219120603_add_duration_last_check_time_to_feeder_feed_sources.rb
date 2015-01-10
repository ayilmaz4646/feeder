class AddDurationLastCheckTimeToFeederFeedSources < ActiveRecord::Migration
  def change
  	change_table  :feeder_feed_sources do |t|
  		t.string    :duration
  		t.datetime  :last_check_time
  	end
  end
end
