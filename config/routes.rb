Rails.application.routes.draw do
  devise_for :users

    root to: "users#dashboard"

    # Add this to your routes.rb file
    post '/checkouts', to: 'checkouts#process_checkouts'


  resources :tasks
  resources :statuses
  resources :users

  resources :statuses do
    resources :tasks
      member do
        get 'mark_resolved'
        get 'mark_completed'
    end
  end

  post '/new_status', to: 'new_status#send_email'
  put 'update_status', to: 'tasks#update_status'
end
