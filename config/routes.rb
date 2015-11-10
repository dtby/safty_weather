Rails.application.routes.draw do
  root "home#index"
  resources :scenes, only: :index
  resources :importants, only: :index do
    collection do
      get :routing
      get :future
    end
  end
  resources :histories, only: :index do
    collection do
      get :list
      get :result
    end
  end
end
