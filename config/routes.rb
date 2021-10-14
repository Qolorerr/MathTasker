Rails.application.routes.draw do
  root 'tasks#index'

  resources :tasks do
    patch :check_user_answer, on: :member
  end

  resources :users

  get 'sign_up' => 'registration#new', as: 'sign_up'
  post 'sign_up' => 'registration#create'
  get 'sign_in' => 'sessions#new', as: 'sign_in'
  post 'sign_in' => 'sessions#create', as: 'log_in'
  delete 'logout' => 'sessions#destroy', as: 'logout'
  get 'password' => 'passwords#edit', as: 'edit_password'
  patch 'password' => 'passwords#update'
end
