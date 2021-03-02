# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiAuthorization::TokenManager do
  let(:user) { create :user }
  subject { described_class }
  describe '#encode_token' do
    context 'when a hash is provided to the method' do
      it 'returns jwt representation of the hash passed in the params' do
        expect(subject.encode_token({ user_id: user.id })).not_to be(nil)
      end
    end
    context 'when nothing is provided to the method' do
      it 'raises a TokenEncodingError exception' do
        expect{ subject.encode_token(nil) }.to raise_error(subject::TokenEncodingError)
      end
    end
  end
end
