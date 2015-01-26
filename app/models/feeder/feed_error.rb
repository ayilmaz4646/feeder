module Feeder
  class FeedError < ActiveRecord::Base
    belongs_to :feed_source
    
    #instance methods
    

    #class methods
    def self.add_new_error(feedSourceId, feedParam, errorMessage, errorType)
    	FeedError.create(feed_source_id: feedSourceId, feed_param: feedParam, error_message: errorMessage, error_type: errorType)
    end
  end
end
