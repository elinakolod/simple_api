# frozen_string_literal: true

module Api
  module V1
    module Videos::Contract
      class Restart < ApplicationContract
        property :start, virtual: true
        property :end, virtual: true

        validation do
          params do
            required(:start).filled(:float)
            required(:end).filled(:float)
          end

          rule(:start) do
            key.failure(I18n.t('errors.time_positive?')) unless value.positive?
          end
          rule(:end) do
            key.failure(I18n.t('errors.time_positive?')) unless value.positive?
          end
        end
      end
    end
  end
end
