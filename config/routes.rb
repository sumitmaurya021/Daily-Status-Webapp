Rails.application.routes.draw do
  devise_for :users

    root to: "users#index"

    # Add this to your routes.rb file
    post '/checkouts', to: 'checkouts#process_checkouts'


  resources :tasks
  resources :statuses

  resources :statuses do
    resources :tasks
  end

  resources :users
end
