Rails.application.routes.draw do
  resources :posts

  mount Comments::Engine, at: '/comments'
  mount Analytics::Engine, at: '/analytics'
  mount Admin::Engine, at: "/admin"

  # Defines the root path route ("/")
  root "posts#index"
end
