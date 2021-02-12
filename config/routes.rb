Rails.application.routes.draw do
  root to: "prototypes#index"
  devise_for :users
  resources :prototypes, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :comments, only: [:create]
  end
  resources :users, only: [:show]
end
