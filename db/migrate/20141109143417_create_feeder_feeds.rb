class CreateFeederFeeds < ActiveRecord::Migration
  def change
    create_table :feeder_feeds do |t|
      t.string :title,    null: false
      t.text   :content,  null: false
      t.string :url,      null: false
      t.text   :analyzed, null: false
      t.string :language

      t.timestamps
    end
  end
end
