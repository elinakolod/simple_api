require 'rails_helper'

RSpec.describe CutterJob, type: :job do
  subject(:cut_video) { described_class.perform_now(video_id: video.id.to_json, start_time: start_time, end_time: end_time) }

  let(:start_time) { 5 }
  let(:end_time) { 10 }
  let(:user) { create(:user) }
  let(:video) { create(:video, file: file_fixture('video.mp4').open, user: user, status: 'scheduled')}

  it 'cuts video' do
    cut_video
    video.reload
    expect(video.status).to eq('done')
    expect(video.file.duration.round).to eq(end_time - start_time)
  end
end
