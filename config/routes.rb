Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'tops#index'

  resources :users, except: %i[index destroy]
  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout
  get 'auth/:provider/callback' => 'user_sessions#create'

  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/callback' => 'oauths#callback' 
  get 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider


  resources :families, only: %i[index new create show edit update] do
    resources :invitations, only: %i[new create]
  end
  resources :invitations, only: [] do
    member do
      get :accept
    end
  end
end