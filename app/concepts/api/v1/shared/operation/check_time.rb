# frozen_string_literal: true

module Api
  module V1
    module Shared::Operation
      class CheckTime < Trailblazer::Operation
        step Rescue(Errors::InvalidTime, handler: Api::V1::Handlers::VideoHandler) {
          pass :invalid_time?
          pass :raise_error
        }

        def invalid_time?(options, model:, params:, **)
          video_duration = model.file.duration
          options[:invalid_time] =
            params[:end].to_i > video_duration || params[:start].to_i > video_duration
        end

        def raise_error(options, **)
          raise Errors::InvalidTime if options[:invalid_time]
        end
      end
    end
  end
end
