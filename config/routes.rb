require 'api_constraints'

Rails.application.routes.draw do

  resources :activities, only: [:index ]

  root 'pages#index'
 
  get 'likes/create'

  resources :pictures

  resources :categories

  resources :listings

  resources :likes, only: :create

  resources :relationships, only: [:create, :destroy]
  
  mount Commontator::Engine => '/commontator'


  get 'pages/index'
  get 'about'       => "pages#about"
  get 'ads'         => "pages#ads"
  get 'browse'      => "pages#browse"
  get 'contact'     => "pages#contact"
  get 'privacy'     => "pages#privacy"
  get 'sellers'     => "sellers#index"
  get 'dashboard'   => "listings#dashboard"
  get 'recent', :to =>"listings#recent",  :as => :recent
  get 'popular',:to =>"listings#popular", :as => :popular
  match '/sellers/:id',to: 'sellers#show', via: 'get'


  devise_for :users, controllers: {:omniauth_callbacks => "users/omniauth_callbacks",
                                   registrations: "users/registrations", 
                                   sessions: "users/sessions", 
                                   passwords: "users/passwords",
                                   :path_prefix => 'd'}, skip: [:sessions, :registrations]

  resources  :sellers, :only =>[:show] do
    member do
      get :following, :followers
    end
  end

  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :restore
      post :mark_as_read
    end
    collection do
      delete :empty_trash
    end
  end
  resources :messages, only: [:new, :create]

  resources :users, only: [:index]

 
  #->Prelang (user_login:devise/stylized_paths)

  devise_scope :user do
    get    "login"   => "users/sessions#new",         as: :new_user_session
    post   "login"   => "users/sessions#create",      as: :user_session
    delete "signout" => "users/sessions#destroy",     as: :destroy_user_session
    
    get    "signup"  => "users/registrations#new",    as: :new_user_registration
    post   "signup"  => "users/registrations#create", as: :user_registration
    put    "signup"  => "users/registrations#update", as: :update_user_registration
    get    "account" => "users/registrations#edit",   as: :edit_user_registration
    
  end


namespace :api, defaults: { format: :json } ,
                            constraints: { subdomain: 'api' }, path: '/'  do
  scope module: :v1 ,
              constraints: ApiConstraints.new(version: 1, default: true) do

  end
end

if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end



mount Koudoku::Engine, at: 'koudoku'
 scope module: 'koudoku' do
 get 'pricing', :to => 'subscriptions#index', as: 'pricing'
end


end
