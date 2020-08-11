class CutterJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: false

  OUTPUT_FILE_PATH = 'tmp/cutted-video.mp4'.freeze

  def perform(video_id:, start_time:, end_time:)
    fetch_video(video_id)
    define_cutting_options(start_time, end_time)
    set_processing
    cut_video
    mark_as_done
  end

  private

  attr_reader :video, :cutting_options

  def fetch_video(video_id)
    @video = Video.find(JSON.parse(video_id))
  end

  def cut_video
    movie = FFMPEG::Movie.new("#{Rails.public_path}#{video.file.url}")
    movie.transcode(OUTPUT_FILE_PATH, cutting_options)
  end

  def define_cutting_options(start_time, end_time)
    @cutting_options = { custom: %W[-ss #{start_time} -to #{end_time}] }
  end

  def mark_as_done
    video.update(status: 'done', file: File.open(OUTPUT_FILE_PATH))
  end

  def set_processing
    video.update(status: 'processing')
  end
end
