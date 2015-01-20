class CreateFeederUserSources < ActiveRecord::Migration
  def change
    create_table :feeder_user_sources do |t|
      t.references :user_id
      t.references :feed_source_id

      t.timestamps
    end
  end
end
