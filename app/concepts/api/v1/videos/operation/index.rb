module Api
  module V1
    class Videos::Index < Trailblazer::Operation
      step Policy::Pundit(VideoPolicy, :index?)
      step :fetch_collection
      step :serialize!

      def fetch_collection(options, current_user:, **)
        options[:model] = VideoPolicy::Scope.new(current_user, Video).resolve
      end

      def serialize!(options, model:, **)
        options[:model] = VideoSerializer.new(model).serializable_hash
      end
    end
  end
end
