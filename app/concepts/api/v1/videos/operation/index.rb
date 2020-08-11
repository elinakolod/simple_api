module Api
  module V1
    class Videos::Index < Trailblazer::Operation
      step :fetch_collection
      step :serialize!

      def fetch_collection!(options, current_user:, **)
        options[:model] = current_user.videos
      end

      def serialize!(options, model:, **)
        options[:model] = VideoSerializer.new(model).serializable_hash
      end
    end
  end
end
