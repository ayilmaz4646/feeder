require_dependency "feeder/application_controller"

module Feeder
  class UserReadlatersController < ApplicationController
    def index
    	@current_user ||= User.find(session[:user_id]) if session[:user_id]
      @feeds = @current_user.feeds.order(created_at: :desc)
    end

  end
end
