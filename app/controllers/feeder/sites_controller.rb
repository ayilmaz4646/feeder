require_dependency "feeder/application_controller"

module Feeder
  class SitesController < ApplicationController
    before_action :require_login

    def index
      @sites = Site.all
    end

    def edit
    	@site = Site.find(params[:id])
    end

    def show
    	@site = Site.find(params[:id])
      @feeds = @site.feeds.order(created_at: :desc).page(params[:page]).per(8)
      #@page = @site.analyze_with_metainspector
    end

  end
end
