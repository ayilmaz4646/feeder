class CreateFeederUserSources < ActiveRecord::Migration
  def change
    create_table :feeder_user_sources do |t|
      t.integer :user_id
      t.integer :feed_source_id

      t.timestamps
    end
  end
end
