require 'rails_helper'

RSpec.describe 'users', type: :request do
  let(:valid_password){ 'secret' }
  let(:user) { create(:user, password: valid_password) }
  describe 'POST users/sign_in' do
    context 'when the login information is valid' do
      it 'returns token' do
        post sign_in_api_v1_users_url, params: { email: user.email, password: valid_password}
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).symbolize_keys).to eq({token:ApiAuthorization::TokenManager.encode_token({user_id: user.id})})
      end
    end
    context 'when the user is not found' do
      it 'raises not found error' do
        post sign_in_api_v1_users_url, params: { email: 'invalidemail', password: valid_password}
        expect(response).to have_http_status(:not_found)
      end
    end
    context 'when the password is incorrect' do
      it 'raises unauthorized error' do
        post sign_in_api_v1_users_url, params: { email: user.email, password: 'invalid_password'}
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end