Rails.application.routes.draw do
  namespace :api do
    get 'users/current', to: 'users#current'

    resources :cars do
      member do
        get 'image'
      end
      resources :reservations, only: [:create, :index]
    end
    
    resources :users, only: [:index, :create, :show]
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'

    resources :reservations, only: [:show, :update, :destroy]
    get 'user_reservations', to: 'reservations#user_reservations'
  end
end
