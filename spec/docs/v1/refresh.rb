module Docs
  module V1
    module Refresh
      extend Dox::DSL::Syntax

      document :api do
        resource 'Refresh' do
          endpoint '/api/v1/refreshs'
          group 'Auth'
          desc 'refresh.md'
        end
      end

      document :create do
        action 'Refresh access token for user'
      end
    end
  end
end
