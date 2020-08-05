RSpec.describe Api::V1::LoginsController, type: :controller do
  describe 'POST #create' do
    let(:password) { 'password' }
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
        expect(JSON.parse(response.body)).to include('csrf')
        expect(response.cookies[JWTSessions.access_cookie]).to be_present
      end
    end

    context 'invalid email' do
      let(:email) { 'wrong_email' }

      it 'returns unauthorized for invalid params' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
