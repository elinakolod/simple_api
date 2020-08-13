# frozen_string_literal: true

module Api
  module V1
    class Videos::Create < Trailblazer::Operation
      step Model(Video, :new)
      step Policy::Pundit(VideoPolicy, :create?)
      step Contract::Build(constant: Videos::Contract::Create)
      step Contract::Validate()
      step Rescue(Mongoid::Errors::Validations, handler: Api::V1::Handlers::ErrorsHandler) {
        step :upload_file
      }
      step Subprocess(Shared::Operation::CheckTime)
      step Subprocess(Shared::Operation::CutVideo)
      step :serialize!

      def upload_file(options, current_user:, params:, **)
        options[:model] = current_user.videos.create!(file: params[:file])
      end

      def serialize!(options, model:, **)
        options[:model] = VideoSerializer.new(model).serializable_hash
      end
    end
  end
end
