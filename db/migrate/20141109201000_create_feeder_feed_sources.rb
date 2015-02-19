class CreateFeederFeedSources < ActiveRecord::Migration
  def change
    create_table  :feeder_feed_sources do |t|

      t.string    :title, null: false
      t.string    :url, unique: true
  		t.string    :duration
  		t.datetime  :last_check_time
      t.timestamps
    end
  end
end
