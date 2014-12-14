Rails.application.routes.draw do

  mount Feeder::Engine => "/feeder"
  mount Resque::Server, at: "/resque"
end
