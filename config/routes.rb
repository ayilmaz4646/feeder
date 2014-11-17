Feeder::Engine.routes.draw do

	resources :feed_sources
	resources :feeds

  get 'home/index'

	root :to => "home#index"
end
