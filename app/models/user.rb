# frozen_string_literal: true

class User
  include Mongoid::Document

  field :email, type: String
end
