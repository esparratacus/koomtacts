# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiAuthorization::TokenManager do
  let(:user) { create :user }
  let(:user_data) { { 'user_id' => user.id } }
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
  describe '#decoded_token' do
    let(:token) { subject.encode_token({ user_id: user.id }) }
    context 'successfully decodes token into a user hash' do
      it 'return user data hash' do
        expect(subject.decoded_token(token)).to(eq(user_data))
      end
    end

    context 'wrong token passed to method' do
      it 'raises a TokenDecodingError' do
        expect{ subject.decoded_token('invalidtoken') }.to raise_error(subject::TokenDecodingError)
      end
    end

    context 'no token provided to method' do
      it 'raises a TokenDecodingError' do
        expect{ subject.decoded_token(nil) }.to raise_error(subject::TokenDecodingError)
      end
    end
  end
end
