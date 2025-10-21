Rails.application.routes.draw do
  resources :posts

  mount Comments::Engine, at: '/comments'

  # Defines the root path route ("/")
  root "posts#index"
end
