# frozen_string_literal: true

module Api
  module V1
    module Shared::Operation
      class CutVideo < Trailblazer::Operation
        step :cut

        def cut(_options, model:, params:, **)
          CutterJob.perform_later(video_id: model.id.to_json, start_time: params[:start], end_time: params[:end])
          model.update(status: 'scheduled')
        end
      end
    end
  end
end
