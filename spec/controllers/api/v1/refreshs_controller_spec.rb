# frozen_string_literal: true

RSpec.describe Api::V1::RefreshsController, type: :controller do
  let(:access_cookie) { tokens[:access] }
  let(:csrf_token) { tokens[:csrf] }
  let(:user) { create(:user) }
  let(:payload) { { user_id: user.id } }
  let(:session) { JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true) }
  let(:tokens) { session.login }

  describe 'POST #create' do
    before do
      JWTSessions.access_exp_time = 0
      tokens
      JWTSessions.access_exp_time = 3600
      request.cookies[JWTSessions.access_cookie] = access_cookie
      request.headers[JWTSessions.csrf_header] = csrf_token
    end

    it 'refreshes access token' do
      post :create
      expect(response).to be_successful
      expect(JSON.parse(response.body)).to include('csrf')
      expect(response.cookies[JWTSessions.access_cookie]).to be_present
    end

    context 'JWTSessions errors' do
      let(:error_message) { /JWTSessions::Errors::ClaimsVerification/ }
      let(:exception) { JWTSessions::Errors::ClaimsVerification }

      before do
        allow_any_instance_of(JWTSessions::Session).to receive(:refresh_by_access_payload).and_raise(exception)
      end

      it 'it fails' do
        post :create
        expect(response.body).to match(error_message)
        expect(response).to have_http_status(401)
      end
    end
  end
end
