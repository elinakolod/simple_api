# frozen_string_literal: true

RSpec.describe Api::V1::Jwt::Refresh do
  let(:access_cookie) { tokens[:access] }
  let(:csrf_token) { tokens[:csrf] }
  let(:user) { create(:user) }
  let(:payload) { { user_id: user.id } }
  let(:session) { JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true) }
  let(:tokens) { session.login }
  let(:params) { { payload: session.payload } }
  let(:refresh_token) { Api::V1::Jwt::Refresh.( params: params ) }

  before do
    JWTSessions.access_exp_time = 0
    tokens
    JWTSessions.access_exp_time = 3600
  end

  it 'is successful' do
    result = refresh_token
    expect(refresh_token).to be_success
    expect(result[:tokens][:access]).not_to be_empty
    expect(result[:tokens][:csrf]).not_to be_empty
  end
end
