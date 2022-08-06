require "sidekiq/pro/web"
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  root "home#index"

  post 'login', to: "users#login", as: :login
  post 'logout', to: "users#logout", as: :logout
  get '/coins', to: "users#coins", as: :user_coins

  get '/coins/:id', to: "coins#show", as: :coin
  post '/coins/:id/add_comment', to: "coins#add_comment", as: :add_comment
end
