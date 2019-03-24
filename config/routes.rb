Rails.application.routes.draw do
  root 'roots#top'
  #ajax用にrouteを追加
  namespace :api, { format: 'json' } do
    get '/json_top', to: 'roots#top'
  end
  get '/about', to: 'roots#about'
  get '/admin_top', to: 'roots#admin_top'

  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  } 
  resources :users, only: [:index, :show, :edit, :update] do
    resources :destinations, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  resources :products, only: [:index, :show, :new, :create, :edit, :update]
  resources :songs

  resources :labels, only: [:index, :new, :create, :edit, :update]
  resources :artists, only: [:index, :new, :create, :edit, :update]
  resources :orders, only: [:index, :show, :create, :edit, :update]

  get 'carts/confirm'
  get 'carts/thanks'
  resources :carts, only: [:show] do
    resources :cart_products, only: [:create, :update, :destroy]
  end


  get 'inquiries/new'
  get 'inquiries/confirm'
  post 'inquiries/confirm' => 'inquiries#confirm'
  get 'inquiries/thanks'
  
  get  'new' =>'inquiries#new'
  post 'thanks' => 'inquiries#thanks'

  # 開発環境メール確認用
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  post  'ajax_test/update', to: 'carts#update', as: 'ajax_test_update'
  post  'shakashaka', to: 'roots#shakashaka', as: 'ajax_shakashaka'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
