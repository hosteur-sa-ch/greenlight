Rails.application.routes.draw do

  # Room resources.
  resources :rooms, only: [:create, :show, :destroy], param: :room_uid, path: '/r'

  # Extended room routes.
  scope '/r/:room_uid' do
    post '/', to: 'rooms#join'
    get '/start', to: 'rooms#start', as: :start_room
    match '/wait', to: 'rooms#wait', as: :wait_room, via: [:get, :post]
    get '/logout', to: 'rooms#logout', as: :logout_room
    get '/sessions', to: 'rooms#sessions', as: :sessions
  end

  # Signup routes.
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  # User settings.
  get '/settings', to: 'users#settings'

  # Handles login of greenlight provider accounts.
  post '/login',  to: 'sessions#create', as: :create_session

  # Login to Greenlight.
  get '/login', to: 'sessions#new'

  # Log the user out of the session.
  get '/logout', to: 'sessions#destroy'

  # Handles launches from a trusted launcher.
  post '/launch', to: 'sessions#launch'

  # Handles Omniauth authentication.
  match '/auth/:provider/callback', to: 'sessions#omniauth', via: [:get, :post], as: :omniauth_session
  get '/auth/failure', to: 'sessions#fail'

  root to: 'main#index'
end
