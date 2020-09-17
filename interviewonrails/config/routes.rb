Rails.application.routes.draw do

    require 'sidekiq/web'
    mount Sidekiq::Web => "/sidekiq"

  resources :interviews
  resources :users
 
  root 'interviews#index'
end
