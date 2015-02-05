module Feeder
  class UserLike < ActiveRecord::Base
  	belongs_to :user, class_name: Feeder.user_class
  	belongs_to :feed, class_name: Feeder::Feed, counter_cache: :likes_count
  end
end
