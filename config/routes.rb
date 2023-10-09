# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /en|zh/ do
    resources :tasks
  end
  root 'tasks#index'
end
