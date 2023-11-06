# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /en|zh/ do
    resources :tasks
  end
  # user
  get '/signup', to: 'users#new'
  resources :users
  # session
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  root 'sessions#new'
end
