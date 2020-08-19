# frozen_string_literal: true

module Api
  module V1
    class VideosController < ApplicationController
      before_action :authorize_access_request!

      def index
        endpoint operation: Videos::Operation::Index
      end

      def create
        endpoint operation: Videos::Operation::Create
      end

      def update
        endpoint operation: Videos::Operation::Restart
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
