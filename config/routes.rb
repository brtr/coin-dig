require "sidekiq/pro/web"
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  root "coins#index"

  post 'login', to: "users#login", as: :login
  post 'logout', to: "users#logout", as: :logout
  get 'users/coins', to: "users#coins", as: :user_coins

  resources :coins, only: [:index, :show] do
    post :add_comment, on: :member
  end
end
