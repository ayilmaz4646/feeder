require_dependency "feeder/application_controller"

module Feeder
  class ReadlatersController < ApplicationController
    
    def index
    	@readlater = Readlater.all
    end

    def show
    	@readlater = Readlater.find(params[:id])
      @feeds = @readlater.feeds.order(created_at: :desc).page(params[:page]).per(8)
    end

  end
end
