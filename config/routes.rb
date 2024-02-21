Rails.application.routes.draw do
  devise_for :employees
  # devise_for :employees

  # devise_for :employees, controllers: {
  #   sessions: 'employees/sessions',
  #   registrations: 'employees/registrations'
  # }

  resources :employees do
    member do
      get "filter_by_date"
      get "filter_by_year"
      get "filter_by_month"
      get "resolve_remarks"
      get "dashboard"
    end
  end
  resources :tasks
  resources :statuses
  resources :employees
end
