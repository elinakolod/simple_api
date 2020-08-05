# frozen_string_literal: true

RSpec.describe Api::V1::LoginsController, type: :controller do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:email) { user.email }
    let(:params) { { email: email } }

    before do
      user
      post :create, params: params
    end

    context 'valid email' do
      it 'returns http success' do
        post :create, params: params
        expect(response).to be_successful
        expect(response.body).to match(/csrf/)
        expect(response.cookies[JWTSessions.access_cookie]).to be_present
      end
    end

    context 'invalid email' do
      let(:email) { 'wrong_email' }
      let(:error_message) { /is in invalid format/ }

      it 'returns unauthorized for invalid params' do
        expect(response.body).to match(error_message)
        expect(response).to have_http_status(401)
      end
    end
  end
end
