Rails.application.routes.draw do
  resources :tasks
  resources :projects
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root "projects#index"
  get "/projects/:id/project_tasks", to: "projects#project_tasks"
end
