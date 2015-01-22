class CreateFeederUserSources < ActiveRecord::Migration
  def change
    create_table :feeder_user_sources do |t|
      t.references :user
      t.references :feed_source

      t.timestamps
    end
  end
end
