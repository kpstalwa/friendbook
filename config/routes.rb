Rails.application.routes.draw do
  get 'likes/create'

  get 'likes/destroy'

  get 'posts/create'

  get 'posts/destroy'

  get 'static_pages/index' => 'static_pages#index'
  resources :friend_requests
  get 'static_pages/home' => 'static_pages#home'
  root 'static_pages#home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, :only => [:show, :index]
  resources :friends, :only => [:index, :destroy]
  resources :posts, :only => [:create, :destroy]
  resources :likes, :only => [:create, :destroy]
  resources :comments, :only => [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
