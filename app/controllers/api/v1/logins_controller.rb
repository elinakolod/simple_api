# frozen_string_literal: true

module Api
  module V1
    class LoginsController < ApplicationController
      def create
        endpoint(operation: Jwt::Login)
      end

      private

      def default_handler
        {
          success: lambda do |result|
            set_token(result[:tokens][:access])
            render json: { csrf: result[:tokens][:csrf] }
          end,
          invalid: lambda do |result|
            render result['contract.default'].errors, status: :unauthorized
          end
        }
      end

      def set_token(token)
        response.set_cookie(JWTSessions.access_cookie,
                            value: token,
                            httponly: true)
      end
    end
  end
end
