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

    def create
    	@feed_source = Feed_source.find(param[:feed_source_id])
    	@feed = @feed_source.feeds.new(feed_params)

    	if @feed.save
      	redirect_to @feed, notice: 'Başarıyla Oluşturuldu'
    	else
      	render :new
    	end
		end

		def destroy
			@feed_source = Feed_source.find(param[:feed_source_id])
    	@feed = @feed_source.feeds.find(params[:id])
    	@feed.destroy
		end

    private
    
    def feed_params
      params.require(:feed).permit(:title, :content, :url, :analyzed, :language)
    end

  end
end
