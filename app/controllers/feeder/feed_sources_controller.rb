require_dependency "feeder/application_controller"

module Feeder
  class FeedSourcesController < ApplicationController
    before_action :require_login, except: [:index, :show]
    #before_action only: [:edit, :update, :destroy] do
     # validate_permission!(set_topic.user)
    #end

  	
    def new
    	@feed_source = FeedSource.new
    end

    def index
      @feed_sources = FeedSource.all.page(params[:page]).per(10)

      if params[:filter] == "user_sources"
        @feed_sources = FeedSource.joins(:user_sources).where("feeder_user_sources.user_id" => current_user.id)
      end
    end

    def edit
    	@feed_source = FeedSource.find(params[:id])
    end

    def follow
      @feed_source  = FeedSource.find(params[:id])
      @feed_source.follow(current_user.id)
    end

    def unfollow
      @feed_source  = FeedSource.find(params[:id])
      @feed_source.unfollow(current_user.id)
    end

    def show
    	@feed_source = FeedSource.find(params[:id])
      @feeds = @feed_source.feeds.order(created_at: :desc).page(params[:page]).per(8)
      #@feed_source.get_entries
      #@feeds = Feedjira::Feed.fetch_and_parse(@feed_source.url)
    end

    def create
      @feed_source = FeedSource.new(feedsource_params)
      if @feed_source.save
        redirect_to @feed_source
      else
        render 'new'
      end
    end

    def update
      @feed_source = FeedSource.find(params[:id])

      if @feed_source.update(feedsource_params)
        redirect_to @feed_source
      else
        render "edit"
      end
    end

    def destroy
      @feed_source = FeedSource.find(params[:id])
      @feed_source.destroy
      
      respond_to do |format|
        format.html { redirect_to @feed_source }
        format.json { head :ok }
      end
    end

    def getentries
      @feed_source = FeedSource.find(params[:id])
      @feed_source.get_entries
      @feeds = @feed_source.feeds.order(created_at: :desc).page(params[:page]).per(8)
      render "show"
    end

    private

    def feedsource_params
      params.require(:feed_source).permit(:title, :url)
    end

  end
end