# frozen_string_literal: true

module Api
  module V1
    class Errors::InvalidTime < StandardError
      def message
        I18n.t('errors.grater_than_duration')
      end
    end
  end
end
