require_dependency "feeder/application_controller"

module Feeder
  class UserReadlatersController < ApplicationController
    def index
    	@readlater = UserReadlater.find(current_user.id)
      @feeds = @readlater.feeds.order(created_at: :desc)
    end
    
  end
end
