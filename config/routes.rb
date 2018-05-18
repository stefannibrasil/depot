Rails.application.routes.draw do
  get 'admin' => 'admin#index'
  root 'store#index', as: 'store_index'
  get "/pages/*id" => 'pages#show', as: :page, format: false

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :users
  resources :orders
  resources :line_items
  resources :carts

  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
