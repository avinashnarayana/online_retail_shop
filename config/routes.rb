Rails.application.routes.draw do
  resources :transfers
  resources :stocks
  resources :locations
  get 'session/cart'

  resources :orders
  resources :products do
    member do 
      get '/new_transfer', to: 'products#new_transfer'
    end
  end 
  root 'static_pages#home'
  get 'users/new'
  
  get  '/about', to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/home', to: 'static_pages#home'
  
  get '/orders', to: 'users#orders'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/add_to_cart',  to: 'sessions#add_to_cart'
  get '/cart', to: 'sessions#show_cart'
  resources :users do
    member do
      get :orders
    end
  end
  
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
