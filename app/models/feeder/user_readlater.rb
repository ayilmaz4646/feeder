module Feeder
  class UserReadlater < ActiveRecord::Base
    belongs_to :user, class_name: Feeder.user_class
    belongs_to :feed, class_name: Feeder::Feed
    belongs_to :readlater
  end
end
