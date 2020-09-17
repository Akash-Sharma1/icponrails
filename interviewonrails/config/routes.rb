Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"

  resources :interviews
  resources :users
 
  root 'interviews#index'

  get '/interviews/:id/remind', to: 'interviews#remind', as: 'interview_remind'


end
