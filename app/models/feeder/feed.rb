module Feeder
  class Feed < ActiveRecord::Base

  	belongs_to :feed_source

  	validates :title,    presence: true
  	#validates :content,  presence:true
  	validates :url,      presence: true
  	
  	

  	
  end
end
