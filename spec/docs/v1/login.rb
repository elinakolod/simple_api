module Docs
  module V1
    module Login
      extend Dox::DSL::Syntax

      document :api do
        resource 'Login' do
          endpoint 'api/v1/logins'
          group 'Auth'
          desc 'login.md'
        end
      end

      document :create do
        action 'Create and sign in user'
      end
    end
  end
end
