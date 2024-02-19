Rails.application.routes.draw do
  resources :employees
  resources :tasks
  resources :statuses
end
