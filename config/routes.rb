Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#member route to display a user's favorites
  resources :users do
    put :favorites, on: :member
  end

  #member route to favorite and unfavorite resources
  resources :resources do
    put :favorite, on: :member
  end
  

  #tags
  get '/tags/new', to: 'tags#new'
  post '/tags', to: 'tags#create'


  #I don't know why we would want this.
  ##Leaving it for now.
  resources :favorites

  #favorites are their own resource - these are extra
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
