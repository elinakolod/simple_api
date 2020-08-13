# frozen_string_literal: true

RSpec.describe Api::V1::VideosController, type: :controller do
  let(:start_time) { 5 }
  let(:end_time) { 10 }
  let(:file_name) { 'video.mp4' }
  let(:video_file) { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/#{file_name}") }
  let(:user) { create(:user) }
  let(:payload) { { user_id: user.id } }
  let(:session) { JWTSessions::Session.new(payload: payload) }
  let(:tokens) { session.login }

  before do
    request.cookies[JWTSessions.access_cookie] = tokens[:access]
    request.headers[JWTSessions.csrf_header] = tokens[:csrf]
    allow(CutterJob).to receive(:perform_later)
  end

  describe 'POST #create' do
    subject(:create_video) { post :create, params: params, as: :json }

    let(:params) { { file: video_file, start: start_time, end: end_time } }

    context 'valid params' do
      it 'is successful' do
        expect { create_video }.to change { Video.count }.by(1)
        expect(response).to be_successful
        expect(CutterJob).to have_received(:perform_later)
        expect(response).to match_json_schema('videos/create')
      end
    end

    context 'invalid start_time' do
      let(:start_time) { -1 }
      let(:error_message) { 'Time should be grater than 0' }

      it 'returns error message' do
        expect { create_video }.not_to change { Video.count }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(CutterJob).not_to have_received(:perform_later)
        expect(response.body).to match(error_message)
      end
    end

    context 'time as string' do
      let(:start_time) { 'invalid_time' }
      let(:error_message) { 'must be an integer' }

      it 'returns error message' do
        expect { create_video }.not_to change { Video.count }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(CutterJob).not_to have_received(:perform_later)
        expect(response.body).to match(error_message)
      end
    end

    context 'invalid end_time' do
      let(:end_time) { 600 }
      let(:error_message) { 'Time can not be grater than duration' }

      it 'returns error message' do
        expect { create_video }.to change { Video.count }.by(1)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(CutterJob).not_to have_received(:perform_later)
        expect(response.body).to match(error_message)
      end
    end

    context 'invalid file' do
      let(:file_name) { 'file.txt' }
      let(:error_message) { 'Validation of Video failed.' }

      it 'returns error message' do
        expect { create_video }.not_to change { Video.count }
        expect(CutterJob).not_to have_received(:perform_later)
        expect(response.body).to match(error_message)
      end

      it 'creates failed video' do
        expect { create_video }.not_to change { Video.count }
      end
    end
  end

  describe 'POST #restart' do
    subject(:restart_processing) { post :restart, params: params, as: :json }

    let(:video) { create(:video, file: video_file, user: user)}
    let(:params) { { id: video.id, start: start_time, end: end_time } }

    before do
      video
    end

    context 'valid params' do
      it 'is successful' do
        expect { restart_processing }.not_to change { Video.count }
        expect(response).to be_successful
        expect(CutterJob).to have_received(:perform_later)
        video.reload
        expect(video.status).to eq('scheduled')
        expect(response).to match_json_schema('videos/restart')
      end
    end

    context 'invalid start_time' do
      let(:start_time) { -1 }
      let(:error_message) { 'Time should be grater than 0' }

      it 'returns error message' do
        expect { restart_processing }.not_to change { Video.count }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(CutterJob).not_to have_received(:perform_later)
        expect(response.body).to match(error_message)
      end
    end

    context 'time as string' do
      let(:start_time) { 'invalid_time' }
      let(:error_message) { 'must be an integer' }

      it 'returns error message' do
        expect { restart_processing }.not_to change { Video.count }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(CutterJob).not_to have_received(:perform_later)
        expect(response.body).to match(error_message)
      end
    end

    context 'invalid end_time' do
      let(:end_time) { 600 }
      let(:error_message) { 'Time can not be grater than duration' }

      it 'returns error message' do
        expect { restart_processing }.not_to change { Video.count }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(CutterJob).not_to have_received(:perform_later)
        expect(response.body).to match(error_message)
      end
    end
  end

  describe 'GET #index' do
    subject(:fetch_videos) { get :index }

    let(:video) { create(:video, file: video_file, user: user) }
    let(:another_video) { create(:video, file: file_fixture('video_copy.mp4').open) }

    before do
      video
      another_video
    end

    it 'is successful' do
      fetch_videos
      expect(response).to be_successful
      expect(response.body).to include(video.id.to_s)
      expect(response.body).not_to include(another_video.id.to_s)
      expect(response).to match_json_schema('videos/index')
    end
  end
end
