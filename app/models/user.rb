# frozen_string_literal: true

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String

  index({ email: 1 }, { unique: true, name: 'email_index' })
end
