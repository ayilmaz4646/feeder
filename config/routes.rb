Feeder::Engine.routes.draw do

  resources :feed_sources do
		get 'follow', on: :member
		get 'unfollow', on: :member
		get 'getentries', on: :member
	end
	resources :feeds do
		get 'like', on: :member
		get 'unlike', on: :member
		get 'readlater', on: :member
		get 'undo_readlater', on: :member
	end
	resources :sites

  #get 'home/index'
	#root to: "feeds#index"
	
end
