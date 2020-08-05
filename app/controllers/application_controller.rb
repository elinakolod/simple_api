# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JWTSessions::RailsAuthorization
  include SimpleEndpoint::Controller

  private

  def default_cases
    {
      success: ->(result) { result.success? },
      invalid: ->(result) { result.failure? }
    }
  end

  def default_handler
    {
      success: ->(result, **opts) { render json: result[:model], **opts, status: 200 },
      invalid: ->(result, **) { render json: result['contract.default'].errors, status: :unprocessable_entity }
    }
  end
end
