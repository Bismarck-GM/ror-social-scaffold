Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  get 'friendships', to: 'friendships#index'

  resources :users, only: [:index, :show] do
    post 'friendships', to: 'friendships#create'
    post 'friendships/accept', to: 'friendships#accept'
    post 'friendships/reject', to: 'friendships#reject'
  end

  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
