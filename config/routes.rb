Blocmarks::Application.routes.draw do
  get "incoming/create"
  resources :names

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, only: [:update]
  get "welcome/index"

  root to: 'welcome#index'

  post :incoming, to: 'incoming#create'
  
  # devise_scope :user do
  #  get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end
end