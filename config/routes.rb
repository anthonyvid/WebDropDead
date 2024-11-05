Rails.application.routes.draw do
  root 'sessions#new'

  get 'account', to: 'users#account', as: 'account'

  # Session routes for sign-in and sign-out
  get 'sign_in', to: 'sessions#new', as: 'sign_in'
  post 'sign_in', to: 'sessions#create'
  delete 'sign_out', to: 'sessions#destroy', as: 'sign_out'

  # Sign-up routes
  get 'sign_up', to: 'users#new', as: 'sign_up'
  post 'sign_up', to: 'users#create'

  # Game routes
  get 'new_game', to: 'games#new', as: 'new_game'
  post 'games', to: 'games#create', as: 'games'  
  get 'games/:id', to: 'games#play', as: 'game'  
  post 'games/:id/replay', to: 'games#replay', as: 'replay_game'
  get 'game_history', to: 'games#history', as: 'game_history' 
  get 'load_game', to: 'games#load', as: 'load_game'
end