Rails.application.routes.draw do
  root "home#index"
  resources :scenes, only: :index
  resources :importants, only: :index
  resources :histories, only: :index do
    collection do
      get :list
      get :result
    end
  end
end
