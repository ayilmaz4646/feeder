require_dependency "feeder/application_controller"

module Feeder
  class FeedsController < ApplicationController

    def index
      @feeds = Feed.all
    end

    def new
    	@feed = Feed.new
    end

    def edit
    	@feed = Feed.find(params[:id])
    end

    def like
      @feed  = Feed.find(params[:id])
      @feed.like(current_user.id)
    end

    def unlike
      @feed  = Feed.find(params[:id])
      @feed.like(current_user.id)
      @user_like = @feed.like(current_user.id)
      @user_like.destroy
    end

    def show
      @feed = Feed.find(params[:id])
      @new_content = @feed.text_extraction_with_alchemyapi
      @author = @feed.author_extraction_with_alchemyapi
      @lang1 = @feed.language_detection_with_alchemyapi
      @title = @feed.title_extraction_with_alchemyapi
      @feed.set_relation_to_sites
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
