BandRater::Application.routes.draw do
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  resources :users
  resources :sessions
  resources :bands do
    collection do
      get "import"
      post "import"
    end
  end
  resources :ratings
  resources :festivals
  resources :lineups, :only => [:create]
  resources :lineups, :only => [:destroy]
  resources :posts
  resources :settings, :only => [:index]
  put "settings" => "settings#update"
  resources :index, :only => [:index]
  root :to => 'index#index'
end
