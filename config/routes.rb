BandRater::Application.routes.draw do
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  resources :users
  resources :sessions
  resources :bands
  resources :ratings
  resources :festivals
  resources :bands_festivals, :only => [:create]
  resources :bands_festivals, :only => [:destroy]
  resources :settings, :only => [:index]
  put "settings" => "settings#update"
  resources :index, :only => [:index]
  root :to => 'index#index'
end
