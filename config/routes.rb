Rails.application.routes.draw do
  get 'songs/index'
  get 'songs/new'
  get 'songs/edit'
  root 'roots#top'
  get '/about', to: 'roots#about'
  get '/admin_top', to: 'roots#admin_top'

  devise_for :users
  resources :users, only: [:index, :show, :edit, :update] do
    resources :destinations, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  resources :products, only: [:index, :show, :new, :create, :edit, :update]
  resources :songs, only: [:create]

  resources :labels, only: [:index, :new, :create, :edit, :update]
  resources :artists, only: [:index, :new, :create, :edit, :update]
  resources :orders, only: [:index, :show, :create, :edit, :update]

  resources :carts, only: [:show] do
    resources :cart_products, only: [:create, :update, :destroy]
  end
  get 'carts/confirm'
  get 'carts/thanks'

  get 'inquiries/new'
  get 'inquiries/confirm'
  get 'inquiries/thanks'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
