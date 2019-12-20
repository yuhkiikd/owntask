Rails.application.routes.draw do
  get 'labels/index'
  get 'sessions/new'
  root 'tasks#index'
  resources :tasks do
    collection do
      get :sort
    end
  end
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users
  end

  resources :labels
end