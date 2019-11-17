Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  resources :users
  resources :labels, only: [:create, :destroy, :show]
end