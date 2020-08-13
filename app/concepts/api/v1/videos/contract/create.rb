# frozen_string_literal: true

module Api
  module V1
    module Videos::Contract
      class Create < ApplicationContract
        property :file
        property :start, virtual: true
        property :end, virtual: true

        validation do
          params do
            required(:file).filled
            required(:start).filled(:integer)
            required(:end).filled(:integer)
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
