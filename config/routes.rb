Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "pages#home"
  get 'toggle_dark_mode', to: 'pages#toggle_dark_mode'
  get 'users', to: 'pages#users'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :issues do
    member do
      post 'upvote'
      post 'remove_upvote'
    end
    resources :alternatives, only: %w[new create edit update]
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

  # CONNECTIONS
  #
  resources :connections do
    member do
      post "check_guess"
    end
    collection do
      get "stats"
    end

    resources :groups, only: %w[new create]
  end

  resources :attempts, only: [] do
    resources :guesses, only: :create
  end

  resources :groups, only: %w[edit update destroy]
end
