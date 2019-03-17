Rails.application.routes.draw do
  root 'roots#top'
  get '/about', to: 'roots#about'
  get '/admin_top', to: 'roots#admin_top'

  devise_for :users
  resources :users, only: [:index, :show, :edit, :update] do
    resources :destinations, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  resources :products, only: [:index, :show, :new, :create, :edit, :update]
  resources :songs

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
  post 'inquiries/confirm' => 'inquiries#confirm'
  get 'inquiries/thanks'
  
  get  'new' =>'inquiries#new'
  post 'thanks' => 'inquiries#thanks'

  # 開発環境メール確認用
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
