module Feeder
  class Readlater < ActiveRecord::Base
    belongs_to :user
    has_many :user_readlater, class_name: Feeder::UserReadlater
  	has_many :feeds, through: :user_readlater
  end
end
