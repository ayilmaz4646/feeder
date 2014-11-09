module Feeder
  class Feed < ActiveRecord::Base

  	belongs_to :feed_source

  	validates :title,    presence: true
  	validates :content,  presence:true
  	validates :url,      presence: true
  	validates :analyzed, presence: true
  	validates :language, presence: true
  end
end
