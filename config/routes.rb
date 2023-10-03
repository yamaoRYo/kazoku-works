Rails.application.routes.draw do
  get 'static_pages/privacy_policy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'tops#index'
  
  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout
  get 'auth/:provider/callback' => 'user_sessions#create'
  
  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/callback' => 'oauths#callback' 
  get 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider

  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'terms_of_service', to: 'static_pages#terms_of_service'

  get '/users', to: redirect('/families')
  
  resources :users, except: %i[index] do
    member do
        delete :destroy_image
    end
  end

  resources :families, only: %i[index new create show edit update] do
    resources :invitations, only: %i[new create]
  end
  resources :invitations, only: [] do
    member do
      get :accept
    end
  end

  resources :events

  resources :memories do
    member do
      delete :delete_photo
    end
  end
end
