module Feeder
  class SitesFeed < ActiveRecord::Base
  	belongs_to :feed, class_name: Feeder::Feed
  	belongs_to :site, class_name: Feeder::Site
  end
end
