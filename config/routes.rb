Rails.application.routes.draw do
  devise_for :users

    root to: "users#index"

    # Add this to your routes.rb file
    post '/checkouts', to: 'checkouts#process_checkouts'


  resources :tasks
  resources :statuses
  resources :remarks

  resources :statuses do
    resources :tasks
    resources :remarks, only: [:create, :update, :destroy]
    member do
      get 'resolve', to: 'statuses#resolve', as: :resolve_status
      get 'complete', to: 'statuses#complete', as: :complete_status
    end
  end

  resources :users
end
