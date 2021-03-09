require 'rails_helper'


RSpec.describe 'contacts_files', type: :request do
  let(:user) { create(:user) }
  let(:token) { "Bearer #{ApiAuthorization::TokenManager.encode_token({user_id: user.id })}" }
  let(:existing_contacts_file) { create(:contacts_file, user: user)}
  let(:valid_attributes) do
    attributes_for(:contacts_file)
  end
  describe '/index' do
    context 'when there are contacts files' do
      let!(:contacts_files) { create_list(:contacts_file, 10, user: user) }
      it 'return an array of contacts' do
        get api_v1_contacts_files_url, headers: { "Authorization" => token }
        expect(response).to have_http_status(:ok)
        expect(json_data).to be_instance_of(Array)
        expect(json_data.size).to eq(10)
      end
    end
  end
  describe '/create' do
    context 'when the object is successfully created' do
      it 'returns created status' do
        post api_v1_contacts_files_url, params: { contacts_file: valid_attributes }, headers: { "Authorization" => token }
        expect(response).to have_http_status(:created)
      end
    end
    context 'when there is a validation error' do
      let(:invalid_attrs) do
        attributes_for(:contacts_file, contacts_csv: nil)
      end
      it 'returns an unprocessable entity error' do
        post api_v1_contacts_files_url, params: { contacts_file: invalid_attrs }, headers: { "Authorization" => token }
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end
  describe '/update' do
    context 'when the object is successfully updated' do
      it 'returns successful status' do
        put api_v1_contacts_file_url(id: existing_contacts_file.id), params: { contacts_file: valid_attributes }, headers: { "Authorization" => token }
        expect(response).to have_http_status(:ok)
      end
    end
  end
  describe '/destroy' do
    context 'when the object is successfully updated' do
      it 'returns successful status' do
        delete api_v1_contacts_file_url(id: existing_contacts_file.id), headers: { "Authorization" => token }
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end