# frozen_string_literal: true

RSpec.describe Api::V1::Videos::Operation::Index do
  subject(:fetch_videos) { Api::V1::Videos::Operation::Index.( current_user: user ) }

  let(:user) { create(:user) }
  let(:video_file) { file_fixture('video.mp4').open }
  let(:video) { create(:video, user: user)}
  let(:another_video) { create(:video) }

  before do
    video
    allow(CutterJob).to receive(:perform_later)
  end

  it 'is successful' do
    result = fetch_videos
    expect(result).to be_success
    expect(result[:model][:data].size).to eq(1)
  end
end
