RhodeProject::Application.routes.draw do


  get "subscriptions/new"

  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :sso, only: :create
  resources :forums
  resources :topics
  resources :posts
  resources :password_resets
  resources :clubs
  resources :events
  resources :tokens, only: :create
  resources :subscriptions, only: [:create, :new]
  resources :profiles
  resources :notices

  root to: 'static_pages#home'
  match '', to: 'static_pages#home', contraints: lambda{|r| r.subdomain == ''}
  match '', to: 'clubs#show', contraints: lambda {|r| r.subdomain.present? && r.subdomain != 'www'}


  match '/user/:id/confirm/:confirm_code', to:'users#confirm'
  match '/signup',  to: 'users#new'
  match '/sponsors', to: 'static_pages#sponsors'
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/signin',  to: 'sessions#new'
  match '/addclub', to: 'clubs#new'
  match '/newforum', to: 'forums#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match 'sitemap',  to: 'sitemap#index', via: :get
  match '/sso',     to: 'sessions#sso', via: :post
  match '/hooks',   to: 'hooks#receiver', via: :post
end
