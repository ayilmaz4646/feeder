module Feeder
  class UserLike < ActiveRecord::Base
  	belongs_to :user, class_name: Feeder.user_class
  	belongs_to :feed, class_name: Feeder::Feed, counter_cache: :likes_count


  	def self.likes_of_user(user_id)
      UserLike.where(user_id: user_id)
    end
  end
end
