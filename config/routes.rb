# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :logins, only: %i[create]
      resource :refreshs, only: %i[create]
    end
  end
end
