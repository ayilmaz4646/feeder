class CreateFeederUserReadlaters < ActiveRecord::Migration
  def change
    create_table :feeder_user_readlaters do |t|
      t.references :user, index: true
      t.references :feed, index: true

      t.timestamps
    end
  end
end
