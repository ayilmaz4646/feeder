require_dependency "feeder/application_controller"

module Feeder
  class FeedsController < ApplicationController

    before_action :set_feed, only: [:show, :edit, :like, :unlike, :destroy, :userreadlater]

    def index
      @feeds = Feed.order(created_at: :desc, likes_count: :desc).page(params[:page]).per(10)
      if params[:filter] == "readlater"
        @feeds = Feed.joins(:user_readlaters).where("feeder_user_readlaters.user_id" => current_user.id).order(created_at: :desc)
      end
      if params[:filter] == "like"
        @feeds = Feed.joins(:user_likes).where("feeder_user_likes.user_id" => current_user.id).order(created_at: :desc)
      end

      #burayı sileceğiz
      if params[:sendmail] == "yes"
        FeedMailer.daily_feeds(current_user.id).deliver_later
      end
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

    def userreadlater
      @feeds = @user_readlater.feeds.where(user_id: current_user.id)      
    end

    def like
      @feed.like(current_user.id)
      @feed.reload
    end

    def unlike
      @feed.unlike(current_user.id)
      @feed.reload
    end

    def readlater
      @feed  = Feed.find(params[:id])
      @feed.readlater(current_user.id)
    end

    def undo_readlater
      @feed  = Feed.find(params[:id])
      @feed.undo_readlater(current_user.id)
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
