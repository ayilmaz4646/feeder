module Feeder
  class Feed < ActiveRecord::Base

  	belongs_to :feed_source

  	validates :title,    presence: true
  	validates :content,  presence:true
  	validates :url,      presence: true
  	
  	after_create :analyze_feed

  	def analyze_feed
  		Resque.enqueue(FeedAnalyzerWorker, self.id)
  	end

  	def text_extraction_with_alchemyapi
  		AlchemyAPI::Config.output_mode = :json
      content = AlchemyAPI::TextExtraction.new.search(url: self.url)
      #self.content = content
      #self.save
      content
  	end

  	end
end
