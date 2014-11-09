class CreateFeederFeedSources < ActiveRecord::Migration
  def change
    create_table :feeder_feed_sources do |t|
      t.string :title
      t.string :url, null: false

      t.timestamps
    end
  end
end
