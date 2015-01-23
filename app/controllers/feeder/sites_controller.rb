require_dependency "feeder/application_controller"

module Feeder
  class SitesController < ApplicationController

    def index
      @site = Site.all
    end

    def edit
    	@site = Site.find(params[:id])
    end

    def show
    	@site = Site.find(params[:id])
    end

  end
end
