Rails.application.routes.draw do
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
end
