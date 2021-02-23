# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Imports::ContactImporter do
  describe '#call' do
    subject { Imports::ContactImporter.new(contacts_file: build(:contacts_file))}
    context 'when the contact only has valid objects' do
      it 'creates contact objects' do
        subject.call
        expect(subject.contacts_file.user.contacts.size).to eq(1)
      end

    end

    context 'when header mappings are not set' do
      it 'should raise a HeaderMappingsNotSetException' do
        subject.contacts_file.header_mappings = nil
        expect { subject.call }.to raise_error(Exceptions::HeaderMappingsNotSetException, 'Header Mappings not set')
      end
    end
  end
end