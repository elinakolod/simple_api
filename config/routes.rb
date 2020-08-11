# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :logins, only: %i[create]
      resource :refreshs, only: %i[create]
      resource :videos, only: %i[index create] do
        post 'restart', on: :member
      end
    end
  end
end
