Rails.application.routes.draw do
  namespace :api do
    resources :tickets
    resources :comments
    resources :teams
    resources :users_tickets, only: %i[create update show destroy]
    resources :users, only: %i[index show create update]

    post '/signup', to: 'users#create'
    get '/me', to: 'users#show'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end

  # Routing logic: fallback requests for React Router.
  # Leave this here to help deploy your app later!
  get '*path',
      to: 'fallback#index',
      constraints: ->(req) { !req.xhr? && req.format.html? }
end
