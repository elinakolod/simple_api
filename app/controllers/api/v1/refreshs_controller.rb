module Api
  module V1
    class RefreshsController < ApplicationController
      before_action :authorize_refresh_by_access_request!

      def create
        endpoint(operation: Jwt::Refresh)
      end

      private

      def endpoint_options
        { params: { payload: claimless_payload } }
      end

      def default_handler
        {
          success: -> (result) do
            set_token(result[:tokens][:access])
            render json: { csrf: result[:tokens][:csrf] }
          end
        }
      end

      def set_token(token)
        response.set_cookie(JWTSessions.access_cookie,
          value: token,
          httponly: true,
          secure: Rails.env.production?)
      end
    end
  end
end
