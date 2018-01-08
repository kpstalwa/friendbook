Rails.application.routes.draw do
  resources :friend_requests
  get 'static_pages/home' => 'static_pages#home'
  root 'static_pages#home'
  devise_for :users, :path => 'u'
  resources :users, :only => [:show, :index]
  resources :friends, :only => [:index, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
