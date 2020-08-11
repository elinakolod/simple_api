# frozen_string_literal: true

require 'streamio-ffmpeg'

class VideoUploader < Shrine
  EXTENSIONS = %w[mp4].freeze
  MAX_SIZE = 20

  Attacher.validate do
    validate_extension EXTENSIONS
    validate_max_size MAX_SIZE * 1024 * 1024
  end

  add_metadata :duration do |io|
    movie = Shrine.with_file(io) { |file| FFMPEG::Movie.new(file.path) }
    movie.duration
  end
end
