Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'pages#home'

  resources :reports do
    member do
      get :status, defaults: { format: 'json' }
    end
  end

  resources :search_results, only: :show do
    member do
      get :preview
    end
  end

  resources :style_guides, only: :index do
    collection do
      get :buttons
      get :morris_charts
      get :forms
      get :grid
      get :icons
      get :tyography
      get :panels
      get :tables
      get :notifications
    end
  end

  resources :queries, only: :index do
    collection do
      get :search
    end
  end

  namespace :api do
    namespace :v1 do
      resources :reports, defaults: { format: 'json' } do
        resources :search_results, defaults: { format: 'json' } do
          member do
            get :preview
          end
        end
      end

      resources :queries, only: [] do
        collection do
          get :search
        end
      end
    end
  end
end
