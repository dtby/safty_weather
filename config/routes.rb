Rails.application.routes.draw do
  root "home#index"
  resources :scenes, only: :index
  resources :importants, only: :index do
    collection do
      get :routing
      get :future
      get :get_typhoon
      get :get_by_unit
      get :get_rain
    end
  end
  resources :histories, only: :index do
    collection do
      get :list
      get :result
    end
  end
end
