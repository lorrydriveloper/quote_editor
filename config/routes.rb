# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :quotes do
    resources :line_item_dates, expect: %i[index show]
  end
end
