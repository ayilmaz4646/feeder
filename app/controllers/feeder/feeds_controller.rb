require_dependency "feeder/application_controller"

module Feeder
  class FeedsController < ApplicationController

    before_action :set_feed, only: [:show, :edit, :like, :unlike, :destroy]

    def index
      @feeds = Feed.order(created_at: :desc, likes_count: :desc).page(params[:page]).per(8)
    end

    def new
    	@feed = Feed.new
    end

    def edit
    end

    def show
      # @new_content = @feed.text_extraction_with_alchemyapi
      # @author = @feed.author_extraction_with_alchemyapi
      # @lang1  = @feed.language_detection_with_alchemyapi
      # @title  = @feed.title_extraction_with_alchemyapi
      #@feed.set_relation_to_sites
    end

    def create
    	
    	@feed = Feed.new(feed_params)

    	if @feed.save
      	redirect_to @feed, notice: 'Başarıyla Oluşturuldu'
    	else
      	render :new
    	end
		end

    def like
      @feed.like(current_user.id)
      @feed.reload
    end

    def unlike
      @feed.unlike(current_user.id)
      @feed.reload
    end

		def destroy
    	@feed.destroy
		end

    private
    def set_feed
      @feed = Feed.find(params[:id])
    end

    def feed_params
      params.require(:feed).permit(:title, :content, :url, :analyzed, :language)
    end

  end
end
