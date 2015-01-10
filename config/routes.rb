Rails.application.routes.draw do

 mount Koudoku::Engine, at: 'koudoku'
 scope module: 'koudoku' do
 get 'pricing', :to => 'subscriptions#index', as: 'pricing'
 end
  
  get 'likes/create'

  resources :pictures

  resources :categories

  resources :listings

  resources :likes, only: :create
  
  mount Commontator::Engine => '/commontator'

  get 'pages/index'
  get 'about'       => "pages#about"
  get 'browse'      => "pages#browse"
  get 'contact'     => "pages#contact"
  get 'privacy'     => "pages#privacy"
  get 'seller'      => "listings#seller"
  get 'recent', :to =>"listings#recent",  :as => :recent
  get 'popular',:to =>"listings#popular", :as => :popular


  devise_for :users, controllers: {:omniauth_callbacks => "users/omniauth_callbacks",registrations: "users/registrations", sessions: "users/sessions", passwords: "users/passwords"}, skip: [:sessions, :registrations]
  
  
  root 'pages#index'

  resources :messages do
    member do
      post :new
    end
  end
  resources :conversations do
  member do
    post :reply
    post :trash
    post :untrash
  end
 collection do
    get :trashbin
    post :empty_trash
  end
 end



 
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


end
