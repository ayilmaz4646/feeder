class AddImageUrlToFeederSites < ActiveRecord::Migration
  def change
    add_column :feeder_sites, :image_url, :string, limit: 1000
  end
end
