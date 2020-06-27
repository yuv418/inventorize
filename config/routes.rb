Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :schemas, controller: :schema
  resources :categories
  resources :items

  root to: "categories#index"
end
