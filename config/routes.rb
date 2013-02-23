BandRater::Application.routes.draw do
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  resources :users do
    collection do
      get "import"
      post "import"
    end
  end
  resources :sessions
  resources :bands do
    collection do
      get "import"
      post "import"
    end
  end
  resources :ratings do
    collection do
      get "import"
      post "import"
    end
  end
  resources :festivals
  resources :lineups, :only => [:create, :destroy] do
    collection do
      get "import"
      post "import"
    end
  end
  resources :posts
  resources :redirects
  resources :settings, :only => [:index]
  put "settings" => "settings#update"
  resources :index, :only => [:index]
  root :to => 'index#index'
  match "*url" => "redirects#redirect"
end
