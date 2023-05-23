Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'home#index'
  authenticate :user do 

    resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy] do
      resource :stock_product_destinations, only: [:create]
    end
    resources :suppliers, only: [:index, :new, :create, :show, :edit, :update]
    resources :product_models, only: [:index, :new, :create, :show]
    resources :orders, only: [:new, :create, :show, :index, :edit, :update] do
      resources :order_items, only: [:new, :create]
      get 'search', on: :collection
      post 'delivered', on: :member
      post 'canceled', on: :member
    end
    namespace :api do
      namespace :v1 do
        resources :warehouses, only: [:show, :index, :create]
      end
    end
  end
end
