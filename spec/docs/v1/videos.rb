module Docs
  module V1
    module Videos
      extend Dox::DSL::Syntax

      document :api do
        resource 'Videos' do
          endpoint '/api/v1/videos'
          group 'Videos'
          desc 'videos.md'
        end
      end
      document :index do
        action 'Get the list of current user videos'
      end
      document :create do
        action 'Upload video and send it to processing'
      end
      document :restart do
        action 'Restart failed request'
      end
    end
  end
end
