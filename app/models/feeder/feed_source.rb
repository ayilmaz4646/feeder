module Feeder
  class FeedSource < ActiveRecord::Base

  	has_many :feeds,  dependent: :destroy

  	validates :title, presence: true
  	validates :url,   presence: true
  end
end
