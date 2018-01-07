Rails.application.routes.draw do
  get 'static_pages/home' => 'static_pages#home'
  root 'static_pages#home'
  devise_for :users
  resources :users, :only => [:show, :index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
