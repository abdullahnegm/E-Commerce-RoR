Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :items
  resources :users
  resources :orders
  resources :order_items

  post '/login', to: 'authentication#login', as: :login
end
