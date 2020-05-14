Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :csv_files, only: [:new, :create, :index]
  resources :contacts,  only: [:index]
  resources :invalid_contacts, only: [:index]
end
