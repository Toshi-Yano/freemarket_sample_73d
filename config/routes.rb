Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: "users/registrations",
  }
  delete "destroy_user_session", to: "devise/sessions#destroy"
  devise_scope :user do
    get "addresses", to: "users/registrations#new_address"
    post "addresses", to: "users/registrations#create_address"
    get "user_show", to: "users/registrations#show"
    get "user_destroy", to: "users/sessions#index"
  end
  root 'items#index'

  resources :items do 
    resources :images, only: [:new, :create]
    collection do
      get 'category/get_category_children', to: 'items#get_category_children', defaults: { format: 'json' }
      get 'category/get_category_grandchildren', to: 'items#get_category_grandchildren', defaults: { format: 'json' }
    end
    member do
      get 'purchase'
      get 'pay'
    end
  end
    
  resources :creditcards, only: [:new, :create, :show, :destroy] do
    collection do
      get 'done_create'
      get 'done_destroy'
    end
  end

  post "items/:id/pay", to: 'items#pay'
  
end
