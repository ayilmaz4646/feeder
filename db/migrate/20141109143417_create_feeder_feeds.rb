class CreateFeederFeeds < ActiveRecord::Migration
  def change
    create_table :feeder_feeds do |t|
      t.string :title,    null: false
      t.text   :content,  null: false
      t.string :url
      t.boolean :analyzed, default: false
      t.string :language, default: false

      t.timestamps
    end
  end
end
