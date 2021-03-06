Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users 
      resources :projects 
      resources :stations, only: :index
      resources :trains, only: :index
      resources :train_tracker, only: [:index]
      resource :sessions, only: [:create, :destroy]
    end 
  end
  root 'home#welcome', as: :unauthenticated_root

end
