# frozen_string_literal: true

class Video
  include Mongoid::Document
  include Mongoid::Timestamps
  include VideoUploader::Attachment(:video)

  field :video_data, type: String
  field :status, type: String

  belongs_to :user
end
