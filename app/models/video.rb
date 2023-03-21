# frozen_string_literal: true

class Video
  include Mongoid::Document
  include Mongoid::Timestamps
  include VideoUploader::Attachment(:file)

  field :file_data, type: String
  field :status, type: String

  belongs_to :user

  validates_presence_of :file
end
