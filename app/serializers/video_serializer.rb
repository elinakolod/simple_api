# frozen_string_literal: true

class VideoSerializer
  include FastJsonapi::ObjectSerializer

  attribute :status
  attribute :duration do |object|
    object.file.duration
  end

  link :url do |object|
    object.file.url
  end
end
