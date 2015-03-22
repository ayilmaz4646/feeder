module Feeder
  class UserReadlater < ActiveRecord::Base
    belongs_to :user, class_name: Feeder.user_class
    belongs_to :feed, class_name: Feeder::Feed
    

    def self.later_readings_of_user(user_id)
      UserReadLater.where(user_id: user_id)
    end
  end
end
