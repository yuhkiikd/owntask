Rails.application.routes.draw do
  get 'sessions/new'
  root 'tasks#index'
  resources :tasks do
    collection do
      get :sort
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :labels, only: [:create, :destroy, :show]
end