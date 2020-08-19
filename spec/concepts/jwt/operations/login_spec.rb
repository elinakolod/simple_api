# frozen_string_literal: true

RSpec.describe Api::V1::Jwt::Operation::Login do
  subject(:login_user) { Api::V1::Jwt::Operation::Login.( params: params ) }

  let(:user) { create(:user) }
  let(:email) { user.email }
  let(:params) { { email: email } }

  context 'valid params' do
    it 'is successful' do
      result = login_user
      expect(result).to be_success
      expect(result[:model]).to eq(user)
      expect(result[:tokens][:access]).not_to be_empty
      expect(result[:tokens][:csrf]).not_to be_empty
    end
  end

  context 'invalid params' do
    let(:email) { 'wrong_email' }
    let(:error_message) { /is in invalid format/ }

    it 'it fails' do
      result = login_user
      expect(result).to be_failure
      expect(result['contract.default'].errors.full_messages).to include(error_message)
    end
  end

  context 'JWTSessions errors' do
    let(:error_message) { /JWTSessions::Errors::InvalidPayload/ }
    let(:exception) { JWTSessions::Errors::InvalidPayload }

    before do
      allow_any_instance_of(JWTSessions::Session).to receive(:login).and_raise(exception)
    end

    it 'it fails' do
      result = login_user
      expect(result).to be_failure
      expect(result[:exception_message]).to match(error_message)
    end
  end
end
