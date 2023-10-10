Rails.application.routes.draw do
  devise_for :admins
  root "welcome#index"
  get "backroom", to: "welcome#backroom"
  scope "/backroom" do
    get "/books/prices_edit" => "books#prices_edit", as: :prices_edit
    post "/books" => "books#prices_update"
    resources :books, :authors, :publishers
  end

  resources :books, only: [:index, :show], as: :frontend_books
  post "/search" => "books#search"

  namespace :api, defaults: { format: :json }  do
    resources :books
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
