Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
  }
  devise_scope :user do
    get "addresses", to: "users/registrations#new_address"
    post "addresses", to: "users/registrations#create_address"
    get "user_show", to: "users/registrations#show"
  end
  root 'items#index'
  resources :items, only: :show
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
