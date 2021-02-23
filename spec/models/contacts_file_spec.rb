# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContactsFile, type: :model do
  subject { build(:contacts_file) }
  it 'has a valid factory' do
    expect(subject).to be_valid
  end
  describe 'validations' do
    it { should validate_presence_of(:contacts_csv) }
    it { should validate_inclusion_of(:status).in_array(ContactsFile::IMPORT_STATUSES).allow_nil }
  end


  describe '#import_contacts' do
    subject { create(:contacts_file)}
    context 'when the contact only has valid objects' do
      it 'creates contact objects' do
        subject.import_contacts
        expect(subject.user.contacts.size).to eq(1)
      end

    end

    context 'when header mappings are not set' do
      it 'should raise a HeaderMappingsNotSetException' do
        subject.header_mappings = nil
        expect { subject.import_contacts }.to raise_error(Exceptions::HeaderMappingsNotSetException, 'Header Mappings not set')
        #expect(subject.status).to eq(ContactsFile::FAILED)
      end
    end

  end
end
