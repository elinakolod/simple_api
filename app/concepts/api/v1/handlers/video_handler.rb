# frozen_string_literal: true

module Api
  module V1
    class Handlers::VideoHandler
      def self.call(exception, (options), *)
        options[:model].update(status: 'failed')
        options[:exception_message] = exception.message
      end
    end
  end
end
