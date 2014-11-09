require_dependency "feeder/application_controller"

module Feeder
  class FeedSourcesController < ApplicationController
  	
    def new
    	@feed_source = Feed_source.new
    end

    def edit
    	@feed_source = Feed_source.find(param[:id])
    end

    def show
    	@feed_source = Feed_source.find(param[:id])
    end
  end
end
