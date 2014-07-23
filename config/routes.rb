Blocmarks::Application.routes.draw do
  devise_for :users
    resources :users, only: [:update]
  get "welcome/index"

  root to: 'welcome#index'
end