# frozen_string_literal: true

module Api
  module V1
    class Jwt::Login < Trailblazer::Operation
      step Model(User, :new)
      step Contract::Build(constant: Jwt::Contract::Login)
      step Contract::Validate()
      step :find_user
      step :create_session
      step :login

      def find_user(options, params:, **)
        options[:model] = User.find_or_create_by(email: params[:email])
      end

      def create_session(options, model:, params:, **)
        options[:session] = JWTSessions::Session.new(payload: { user_id: model.id }, refresh_by_access_allowed: true)
      end

      def login(options, session:, **)
        options[:tokens] = session.login
      end
    end
  end
end
