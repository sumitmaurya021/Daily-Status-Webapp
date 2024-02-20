Rails.application.routes.draw do

  root to: "sessions#new"

  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout
  get '/signup', to: 'employees#new', as: 'signup'

  resources :employees do
    member do
      get "filter_by_date"
      get "filter_by_year"
      get "filter_by_month"
      get "resolve_remarks"
    end
  end
  resources :tasks
  resources :statuses
end
