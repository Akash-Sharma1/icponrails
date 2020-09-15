Rails.application.routes.draw do

  resources :interviews
  resources :users
 
  root 'interviews#index'
end
