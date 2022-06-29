Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "pages#home"
  get 'toggle_dark_mode', to: 'pages#toggle_dark_mode'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :issues do
    member do
      post 'upvote'
      post 'remove_upvote'
    end
    resources :alternatives, only: :create
  end
  resources :resources do
    member do
      post 'upvote'
      post 'remove_upvote'
    end
  end
  resources :alternatives, only: :create do
    member do
      post 'upvote'
      post 'remove_upvote'
    end
  end
end
