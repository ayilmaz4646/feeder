require_dependency "feeder/application_controller"

module Feeder
  class FeedsController < ApplicationController

    def new
    	@feed = Feed.new
    end

    def edit
    	@feed = Feed.find(params[:id])
    end

    def show
      @feed = Feed.find(params[:id])
      @new_content = @feed.text_extraction_with_alchemyapi
    end

    def create
    	
    	@feed = Feed.new(feed_params)

    	if @feed.save
      	redirect_to @feed, notice: 'Başarıyla Oluşturuldu'
    	else
      	render :new
    	end
		end

		def destroy
    	@feed = Feed.find(params[:id])
    	@feed.destroy
		end

    private
    
    def feed_params
      params.require(:feed).permit(:title, :content, :url, :analyzed, :language)
    end

  end
end
