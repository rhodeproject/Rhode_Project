RhodeProject::Application.routes.draw do


  get "leaders/index"

  get "subscriptions/new"

  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
  resources :microposts, :only => [:create, :destroy]
  resources :relationships, :only => [:create, :destroy]
  resources :sso, :only => :create
  resources :forums
  resources :topics
  resources :posts
  resources :password_resets
  resources :clubs
  resources :events
  resources :tokens, :only => :create
  resources :subscriptions, :only => [:create, :new]
  resources :profiles
  resources :notices
  resources :sponsors
  resources :renew_users
  resources :leaders


  root :to => 'static_pages#home'
  match '/home', :to => 'static_pages#home'
  #match '', :to => 'static_pages#home', :contraints => lambda{|r| r.subdomain == ''}
  #match '', :to => 'clubs#show', :contraints => lambda {|r| r.subdomain.present? && r.subdomain != 'www'}

  match 'renew_users/:id', :to => 'renew_users#new'
  match '/user/:id/confirm/:confirm_code', :to =>'users#confirm'
  match '/signup',  :to => 'users#new'
  match '/sponsors', :to => 'static_pages#sponsors'
  match '/help',    :to => 'static_pages#help'
  match '/about',   :to => 'static_pages#about'
  match '/contact', :to => 'clubs#contact', :via => :post
  match '/signin',  :to => 'sessions#new'
  match '/addclub', :to => 'clubs#new'
  match '/newforum', :to => 'forums#new'
  match '/signout', :to => 'sessions#destroy', :via => :delete
  match 'sitemap',  :to => 'sitemap#index', :via => :get
  match '/sso',     :to => 'sessions#sso', :via => :post
  match '/hooks',   :to => 'hooks#receiver', :via => :post
  match '/subscription_hook', :to => 'hooks#subscription', :via => :post
  match '/club/payments', :to => 'clubs#payments'
  match 'club/charge', :to => 'clubs#charge'
  match 'club/refund', :to => 'clubs#refund'
  match 'club/stripesubscription', :to => 'clubs#stripesubscription'
  match 'topics/ajax', :to => 'topics#update'
  match 'topics/addtopic', :to => 'topics#create'

  #validation
  match 'user/validation', :to => 'users#validation', :via => :get
  match 'club/validation', :to => 'clubs#validation', :via => :get

end
