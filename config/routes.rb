Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#member route to display a user's favorites
  resources :users
    put :favorites, on: :member

  #member route to favorite and unfavorite resources
  resources :resources
    put :favorite, on: :member

  #I don't know why we would want this.
  ##Leaving it for now.
  resources :favorites

  #tags
  get '/tags/new', to: 'tags#new'
  post '/tags', to: 'tags#create'

  #favorites are their own resource
  get '/favorites/new', to: 'favorites#show'
  post '/favorites', to: 'favorites#create'

  #set root
  root 'application#index'

  #match custom routes
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/search' => 'resources#search'

  #thoughts:
  ## user

end
