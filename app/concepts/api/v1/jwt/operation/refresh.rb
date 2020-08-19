# frozen_string_literal: true

module Api
  module V1
    module Jwt::Operation
      class Refresh < Trailblazer::Operation
        step Rescue(JWTSessions::Errors::Error, handler: Api::V1::Handlers::ErrorsHandler) {
          step :create_session
          step :refresh_session
        }

        def create_session(options, params:, **)
          options[:session] = JWTSessions::Session.new(payload: params[:payload], refresh_by_access_allowed: true)
        end

        def refresh_session(options, session:, **)
          options[:tokens] = session.refresh_by_access_payload
        end
      end
    end
  end
end
