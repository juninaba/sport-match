Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :prefectures

  resources :users do
    member do
     get :following, :followers
    end
    resources :details, only: [:index, :new, :create, :edit, :update]
  end

  resources :rooms, only: [:show]

  resources :relationships, only: [:create, :destroy]
  # mount ActionCable.server => '/cable'

end
