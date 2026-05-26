Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :user,
      controllers: {
         omniauth_callbacks: 'users/omniauth_callbacks'
      }
  resources :characters, only: [:edit, :update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :characters, only: [:new, :create]
  # resources :chats, only: [:new, :create]
  # resources :messages, only: [:new, :create]
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
<<<<<<< HEAD

  resources :characters, only: [:index, :show]
=======
  #

>>>>>>> origin/new-create
end
