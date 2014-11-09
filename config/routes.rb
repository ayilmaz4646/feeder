Feeder::Engine.routes.draw do
  get 'feeds/new'

  get 'feeds/edit'

  get 'feeds/show'

  get 'feed_sources/new'

  get 'feed_sources/edit'

  get 'home/index'

	root :to => "home#index"
end
