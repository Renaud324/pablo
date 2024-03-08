require "sidekiq/web"

Rails.application.routes.draw do
  root 'pages#home'
  get "search", to: "pages#search"

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :companies
  resources :tasks, only: %i[index create]
  resources :job_applications
  resources :interactions, only: %i[index create]


  mount Sidekiq::Web => '/sidekiq'

  get 'openai', to: 'openai#index'
  resources :job_applications do
    resources :interactions, only: [:index]
    resources :tasks, only: [:index]
    collection do
    post 'refresh'
    end
    resources :tasks, only: %i[index]
  end
end
