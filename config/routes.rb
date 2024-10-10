Rails.application.routes.draw do
  get 'stimulus/imdb'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get "/imdb", to: "lists#index"
  post "/imdb/import", to: "lists#import_and_create"
  get "imdb/:id", to: "lists#show"
  post "/imdb/filter", to: "lists#filter", as: :imdb_filter
  get "/fluxfm", to: "lists#fluxindex"
  get "/nasa", to: "lists#nasa"

  scope "/imdb" do
    resources :lists, only: [:edit, :update, :destroy]
  end
end
