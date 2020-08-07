# frozen_string_literal: true

module Api
  module V1
    module Jwt::Contract
      class Login < ApplicationContract
        property :email

        validation do
          params do
            required(:email).filled(format?: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)
          end
        end
      end
    end
  end
end
