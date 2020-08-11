# frozen_string_literal: true

module Api
  module V1
    class VideosController < ApplicationController
      before_action :authorize_access_request!

      def index
        endpoint operation: Videos::Index
      end

      def create
        endpoint operation: Videos::Create
      end

      def restart
        endpoint operation: Videos::Restart
      end

      private

      def endpoint_options
        { params: permitted_params, current_user: current_user }
      end

      def permitted_params
        params.permit(:id, :file, :start, :end)
      end
    end
  end
end
