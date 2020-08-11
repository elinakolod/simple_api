module Api
  module V1
    class Handlers::ErrorsHandler
      def self.call(exception, (options), *)
        options[:exception_message] = exception.message
      end
    end
  end
end
