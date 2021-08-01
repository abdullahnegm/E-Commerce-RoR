Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root      'orders#index'
  resources :items
  resources :users
  resources :orders
  resources :order_items
  post      '/purchase', to: 'purchases#create'
  post      '/checkout', to: 'check_outs#create'
  put       '/checkout', to: 'check_outs#update'

  post '/login', to: 'authentication#login', as: :login
end
