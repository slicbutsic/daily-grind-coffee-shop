Rails.application.routes.draw do
  # get 'reviews/create'
  devise_for :users
  # root to: 'products#index'
  root to: 'homes#index'

  get '/coffee_quiz', to: 'quizzes#new'
  post '/coffee_quiz', to: 'quizzes#result'

  resources :categories, only: [:index, :show]

  resources :products, only: %i[index show] do
    # resources :reviews, only: [:create]
  end

  resource :cart, only: [:show] do
    post 'add_item', on: :collection
    patch 'update_quantity', on: :collection
    delete 'empty', on: :collection
  end

  resources :checkouts, only: [:new, :create]
  resources :orders, only: [:index, :show]

  resource :wishlist, only: [:show] do
    post 'toggle/:id', to: 'wishlists#toggle_item', as: 'toggle_item'
    member do
      post 'toggle_item'
      delete :remove_item
    end
  end

  get '/confirm_address', to: 'addresses#new'
  post '/confirm_address', to: 'addresses#create'
  get 'calculate_shipping', to: 'addresses#calculate_shipping'


  # Add these new routes for the cart API and cart item updates
  # get '/api/cart', to: 'carts#api_show'
  # patch '/api/cart_items/:id', to: 'cart_items#update'
end
