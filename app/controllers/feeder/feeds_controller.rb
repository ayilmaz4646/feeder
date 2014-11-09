require_dependency "feeder/application_controller"

module Feeder
  class FeedsController < ApplicationController

    def new
    	@feed_source = Feed_source.find(param[:feed_source_id])
    	@feed = @feed_source.feeds.new
    end

    def edit
    	@feed_source = Feed_source.find(param[:feed_source_id])
    	@feed = @feed_source.feeds.find(params[:id])
    end

  end
end
