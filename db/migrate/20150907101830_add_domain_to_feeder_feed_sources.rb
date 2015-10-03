class AddDomainToFeederFeedSources < ActiveRecord::Migration
  def change
  	change_table :feeder_feed_sources do |t|
  		t.string   :domain_name
  	end
  end
end
