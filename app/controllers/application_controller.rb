# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JWTSessions::RailsAuthorization
  include SimpleEndpoint::Controller
  include Pundit

  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

  private

  def current_user
    token = request_cookies[JWTSessions.cookie_by(:access)]
    @current_user ||= User.find(payload['user_id']) if token.present?
  rescue JWTSessions::Errors::Expired
    @current_user ||= User.find(claimless_payload['user_id'])
  end

  def not_authorized
    render json: { error: 'Not authorized' }, status: :unauthorized
  end

  def default_cases
    {
      success: ->(result) { result.success? },
      invalid: ->(result) { result.failure? }
    }
  end

  def default_handler
    {
      success: ->(result, **opts) { render json: result[:model], **opts, status: 200 },
      invalid: ->(result, **) do
        render json: result[:exception_message] || result['contract.default'].errors.full_messages, status: :unprocessable_entity
      end
    }
  end
end
