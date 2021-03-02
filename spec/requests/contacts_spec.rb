require 'rails_helper'

RSpec.describe 'users/contacts', type: :request do
  let(:user) { create(:contacts_file).user}
  before(:each) do
    sign_in user
  end
  describe 'GET /index' do
    it 'renders a successful response' do
      get contacts_url
      expect(response).to be_successful
    end
  end
end