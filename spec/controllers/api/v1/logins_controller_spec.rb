# frozen_string_literal: true

RSpec.describe Api::V1::LoginsController, type: :controller do
  include Docs::V1::Login::Api

  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:email) { user.email }
    let(:params) { { email: email } }

    context 'valid email' do
      include Docs::V1::Login::Create
      it 'returns http success', :dox do
        post :create, params: params
        expect(response).to be_successful
        expect(response.body).to match(/csrf/)
        expect(response.cookies[JWTSessions.access_cookie]).to be_present
      end
    end

    context 'invalid email' do
      let(:email) { 'wrong_email' }
      let(:error_message) { /is in invalid format/ }

      it 'returns unauthorized' do
        post :create, params: params
        expect(response.body).to match(error_message)
        expect(response).to have_http_status(401)
      end
    end

    context 'JWTSessions errors' do
      let(:error_message) { /JWTSessions::Errors::InvalidPayload/ }
      let(:exception) { JWTSessions::Errors::InvalidPayload }

      before do
        allow_any_instance_of(JWTSessions::Session).to receive(:login).and_raise(exception)
      end

      it 'returns unauthorized' do
        post :create, params: params
        expect(response.body).to match(error_message)
        expect(response).to have_http_status(401)
      end
    end
  end
end
