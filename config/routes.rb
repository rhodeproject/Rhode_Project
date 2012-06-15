RhodeProject::Application.routes.draw do


  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :forums
  resources :topics
  resources :posts
  resources :password_resets
  resources :clubs
  resources :events

  root to: 'static_pages#home'
  match '/signup',  to: 'users#new'
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/signin',  to: 'sessions#new'
  match '/addclub', to: 'clubs#new'
  match '/newforum', to: 'forums#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match 'sitemap',  to: 'sitemap#index', via: :get
end
