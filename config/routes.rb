Rails.application.routes.draw do
  resources :posts

  mount Comments::Engine, at: '/comments'
  mount Analytics::Engine, at: '/analytics'

  # Defines the root path route ("/")
  root "posts#index"
end
