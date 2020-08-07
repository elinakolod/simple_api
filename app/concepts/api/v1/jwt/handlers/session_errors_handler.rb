module Api
  module V1
    module Jwt
      class Handlers::SessionErrorsHandler
        def self.call(exception, (options), *)
          options[:exception_message] = exception.message
        end
      end
    end
  end
end
