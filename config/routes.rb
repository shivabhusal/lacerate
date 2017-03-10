Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'

  resources :reports

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

  namespace :api do
    namespace :v1 do
      resources :reports, defaults: { format: 'json' }
    end
  end
end
