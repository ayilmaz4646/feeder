Feeder::Engine.routes.draw do

  resources :feed_sources do
		get 'follow', on: :member
		get 'unfollow', on: :member
		get 'getentries', on: :member
	end
	resources :feeds do
		get 'like', on: :member
		get 'unlike', on: :member
	end
	resources :feeds do
		get 'readlater', on: :member
		get 'undo_readlater', on: :member
		get 'today', on: :collection
	end
	resources :sites

  #get 'home/index'
	#root :to => "home#index"
end
