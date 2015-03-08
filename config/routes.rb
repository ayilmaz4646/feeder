Feeder::Engine.routes.draw do

  get 'user_readlaters/index'

  get 'user_readlaters/show'

	resources :feed_sources do
		get 'follow', on: :member
		get 'unfollow', on: :member
	end
	resources :feeds do
		get 'like', on: :member
		get 'unlike', on: :member
	end
	resources :feeds do
		get 'readlater', on: :member
		get 'undo_readlater', on: :member
	end
	resources :sites
	resources :user_readlaters
	

  #get 'home/index'
	#root :to => "home#index"
end
