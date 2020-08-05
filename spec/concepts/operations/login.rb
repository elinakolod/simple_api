# frozen_string_literal: true

RSpec.describe Api::V1::Jwt::Login do
  let(:user) { create(:user) }
  let(:email) { user.email }
  let(:params) { { email: email } }
  let(:login_user) { Api::V1::Jwt::Login.( params: params ) }

  before do
    user
  end

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
      #expect(result['contract.default'].errors).to match(error_message)
    end
  end
end
