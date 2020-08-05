module Api
  module V1
    class LoginsController < ApplicationController
      def create
        endpoint(operation: Jwt::Login)
      end

      private

      def default_handler
        {
          success: -> (result) do
            set_token(result[:tokens][:access])
            render json: { csrf: result[:tokens][:csrf] }
          end,
          invalid: -> (result) do
            binding.pry
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
