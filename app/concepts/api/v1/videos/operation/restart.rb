
module Api
  module V1
    module Videos::Operation
      class Restart < Trailblazer::Operation
        step Model(Video, :find_by)
        step Policy::Pundit(VideoPolicy, :restart?)
        step Contract::Build(constant: Videos::Contract::Restart)
        step Contract::Validate()
        step Subprocess(Shared::Operation::CheckTime)
        step Subprocess(Shared::Operation::CutVideo)
        step :serialize!

        def serialize!(options, model:, **)
          options[:model] = VideoSerializer.new(model).serializable_hash
        end
      end
    end
  end
end
