Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :issues do
    resources :alternatives, only: :create
    member do
      post 'upvote'
      post 'remove_upvote'
    end
  end
  resources :resources
  # Defines the root path route ("/")
  # root "articles#index"
end
