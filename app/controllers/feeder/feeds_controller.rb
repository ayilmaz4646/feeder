require_dependency "feeder/application_controller"

module Feeder
  class FeedsController < ApplicationController

    def new
    	@feed = Feeds.new
    end

    def edit
    	@feed = Feeds.find(params[:id])
    end

    def create
    	
    	@feed = Feeds.new(feed_params)

    	if @feed.save
      	redirect_to @feed, notice: 'Başarıyla Oluşturuldu'
    	else
      	render :new
    	end
		end

		def destroy
    	@feed = Feeds.find(params[:id])
    	@feed.destroy
		end

    private
    
    def feed_params
      params.require(:feed).permit(:title, :content, :url, :analyzed, :language)
    end

  end
end
