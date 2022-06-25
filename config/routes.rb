Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :issues do
    member do
      post 'upvote'
      post 'remove_upvote'
    end
    resources :alternatives, only: :create
  end
  resources :resources
  resources :alternatives, only: :create do
    member do
      post 'upvote'
      post 'remove_upvote'
    end
  end
end
