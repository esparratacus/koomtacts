require 'rails_helper'


RSpec.describe 'contacts', type: :request do
  let(:user) { create(:user) }
  let(:token) { "Bearer #{ApiAuthorization::TokenManager.encode_token({user_id: user.id })}" }
  describe '/index action' do
    context 'when there are contacts' do
      let!(:contacts) { create_list(:contact,10, user: user) }
      it 'return an array of contacts' do
        get api_v1_contacts_url, headers: { "Authorization" => token }
        expect(response).to have_http_status(:ok)
        expect(json_data).to be_instance_of(Array)
        expect(json_data.size).to eq(10)
      end
    end
    context 'when there are no contacts' do
      it 'returns an empty array' do
        get api_v1_contacts_url, headers: { "Authorization" => token }
        expect(response).to have_http_status(:ok)
        expect(json_data).to be_instance_of(Array)
        expect(json_data).to be_empty
      end
    end
  end
end