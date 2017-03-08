Rails.application.routes.draw do
  get 'style_guides/buttons'

  get 'style_guides/flot'

  get 'style_guides/forms'

  get 'style_guides/grid'

  get 'style_guides/icons'

  get 'style_guides/tyography'

  get 'style_guides/panels'

  get 'style_guides/tables'

  get 'style_guides/notifications'

  root 'pages#home'

  resources :reports
end
