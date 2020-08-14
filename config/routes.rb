Rails.application.routes.draw do
  get 'home', to: 'home#index', as: :trangchu
  get 'login', to: 'session#login', as: :login
  post 'login', to: 'session#signin', as: :post_login
  delete 'logout', to: 'session#destroy', as: :logout
  get 'register', to: 'session#register', as: :register
  post 'register', to: 'session#create', as: :post_register
  get 'forgotpassword', to: 'session#forgot_password', as: :forgot_password
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
