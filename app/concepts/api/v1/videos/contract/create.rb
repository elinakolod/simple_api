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
            required(:file).filled(:string)
            required(:start).filled
            required(:end).filled
          end

          rule(:start, :end) do
            key.failure(I18n.t('errors.time_positive?')) unless Float(value).positive?
          end
        end
      end
    end
  end
end
