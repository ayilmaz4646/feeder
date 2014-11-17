class CreateFeederFeedSources < ActiveRecord::Migration
  def change
    create_table :feeder_feed_sources do |t|

      t.string :title, null: false
      t.string :url

      t.timestamps
    end
  end
end
