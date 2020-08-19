# frozen_string_literal: true

RSpec.describe Api::V1::Videos::Operation::Restart do
  subject(:restart_processing) { Api::V1::Videos::Operation::Restart.( params: params, current_user: user ) }

  let(:start_time) { 5 }
  let(:end_time) { 10 }
  let(:user) { create(:user) }
  let(:video) { create(:video, user: user, status: 'failed')}
  let(:params) { { id: video.id, start: start_time, end: end_time} }

  before do
    video
    allow(CutterJob).to receive(:perform_later)
  end

  context 'valid params' do
    it 'is successful' do
      result = restart_processing
      expect(result).to be_success
      expect(CutterJob).to have_received(:perform_later)
      video.reload
      expect(video.status).to eq('scheduled')
    end

    it 'does not create video' do
      expect { restart_processing }.not_to change { Video.count }
    end
  end

  context 'invalid start_time' do
    let(:start_time) { -1 }
    let(:error_message) { 'Start Time should be grater than 0' }

    it 'returns error message' do
      result = restart_processing
      expect(result).to be_failure
      expect(CutterJob).not_to have_received(:perform_later)
      expect(result['contract.default'].errors.full_messages).to include(error_message)
    end

    it 'does not create video' do
      expect { restart_processing }.not_to change { Video.count }
    end
  end

  context 'invalid end_time' do
    let(:end_time) { 600 }
    let(:error_message) { 'Time can not be grater than duration' }

    it 'returns error message' do
      result = restart_processing
      expect(result).to be_failure
      expect(CutterJob).not_to have_received(:perform_later)
      expect(result[:exception_message]).to match(error_message)
      expect(result[:model].status).to eq('failed')
    end

    it 'does not create video' do
      expect { restart_processing }.not_to change { Video.count }
    end
  end

  context 'start time as string' do
    let(:start_time) { 'invalid_time' }
    let(:error_message) { 'Start must be a float' }

    it 'returns error message' do
      result = restart_processing
      expect(result).to be_failure
      expect(CutterJob).not_to have_received(:perform_later)
      expect(result['contract.default'].errors.full_messages).to include(error_message)
    end

    it 'does not create video' do
      expect { restart_processing }.not_to change { Video.count }
    end
  end

  context 'end time as string' do
    let(:end_time) { 'invalid_time' }
    let(:error_message) { 'End must be a float' }

    it 'returns error message' do
      result = restart_processing
      expect(result).to be_failure
      expect(CutterJob).not_to have_received(:perform_later)
      expect(result['contract.default'].errors.full_messages).to include(error_message)
    end

    it 'does not create video' do
      expect { restart_processing }.not_to change { Video.count }
    end
  end

  context 'start time as string' do
    let(:start_time) { 'invalid_time' }
    let(:error_message) { 'Start must be a float' }

    it 'returns error message' do
      result = restart_processing
      expect(result).to be_failure
      expect(CutterJob).not_to have_received(:perform_later)
      expect(result['contract.default'].errors.full_messages).to include(error_message)
    end

    it 'does not create video' do
      expect { restart_processing }.not_to change { Video.count }
    end
  end

  context 'end time as string' do
    let(:end_time) { 'invalid_time' }
    let(:error_message) { 'End must be a float' }

    it 'returns error message' do
      result = restart_processing
      expect(result).to be_failure
      expect(CutterJob).not_to have_received(:perform_later)
      expect(result['contract.default'].errors.full_messages).to include(error_message)
    end

    it 'does not create video' do
      expect { restart_processing }.not_to change { Video.count }
    end
  end
end
