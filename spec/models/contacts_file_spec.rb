# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContactsFile, type: :model do
  describe 'Object validation' do
    context 'when contacts field is not present' do
      it 'should not have a valid contacts file field'
    end
    context 'when the status value is not among the permitted values' do
      it 'should not have a valid status field'
    end
  end

  describe '#import_contacts' do
    context 'when the contact only has valid objects' do
      it 'should update the contacts_file object to processing'
      it 'should create all the contact objects'
      it 'should not have any importer_log records'
      it 'should have a FINISHED status'
    end

    context 'when header mappings are not set' do
      it 'should raise a HeaderMappingsNotSet exception'
      it 'should set status value to FAILED'
    end

    context 'when some contact objects could not be created' do
      it 'should create importer log objects at least once'
      it 'should set status value to FINISHED'
    end
  end
end
