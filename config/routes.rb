Feeder::Engine.routes.draw do

	resources :feed_sources do
		put 'follow', on: :member
	end
	resources :feeds
	resources :sites

  #get 'home/index'
	#root :to => "home#index"
end
