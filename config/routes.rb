# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :logins, only: %i[create]
      resources :refreshs, only: %i[create]
      resources :videos, only: %i[index create] do
        post 'restart', on: :member
      end
    end
  end
end
