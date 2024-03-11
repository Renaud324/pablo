require "sidekiq/web"

Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  get "up" => "rails/health#show", as: :rails_health_check
  mount Sidekiq::Web => '/sidekiq'
  get 'openai', to: 'openai#index'
  get "search", to: "pages#search"

  resources :job_applications do
    resources :interactions, only: [:index]
    resources :tasks, only: [:index]
    patch :update_status, on: :member
    collection do
      post 'refresh'
    end
  end
  resources :companies
  resources :tasks, only: %i[index create]
  resources :interactions, only: %i[index create destroy]

end
