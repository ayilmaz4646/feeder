Feeder::Engine.routes.draw do

	resources :feed_sources
	resources :feeds
	resources :sites

  #get 'home/index'
	#root :to => "home#index"
end
