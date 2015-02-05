module Feeder
  class UserSource < ActiveRecord::Base
  	belongs_to :feed_source, class_name: Feeder::FeedSource
  	belongs_to :user, class_name: Feeder.user_class
  end
end
