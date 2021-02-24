# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Imports::ContactImporter do
  describe '#call' do
    subject { described_class.new(contacts_file: build(:contacts_file)) }
    context 'when the contacts file only has valid objects' do
      it 'creates contact objects' do
        subject.call
        expect(subject.contacts_file.user.contacts.size).to eq(1)
      end
      it 'changes status to FINISHED' do
        subject.call
        expect(subject.contacts_file.finished?).to be_truthy
      end
    end

    context 'when the contacts file has invalid objects' do
      subject { described_class.new(contacts_file: build(:contacts_file, :contacts_file_with_errors)) }
      it 'should create importer log object' do
        subject.call
        expect(subject.contacts_file.importer_logs.size).to eq(1)
      end
      it 'changes status to FAILED' do
        subject.call
        expect(subject.contacts_file.failed?).to be_truthy
      end
    end

    context 'when the contacts file has valid AND invalid objects' do
      subject { described_class.new(contacts_file: build(:contacts_file, :mixed_objects)) }
      it 'should create importer log object' do
        subject.call
        expect(subject.contacts_file.importer_logs.size).to eq(1)
      end
      it 'changes status to FINISHED' do
        subject.call
        expect(subject.contacts_file.finished?).to be_truthy
      end
    end

    context 'when header mappings are not set' do
      it 'raises a HeaderMappingsNotSetException' do
        subject.contacts_file.header_mappings = nil
        expect { subject.call }.to raise_error(Exceptions::HeaderMappingsNotSetException, 'Header Mappings not set')
      end
    end

    context 'when file is not found' do
      it 'changes status to PROCESSING_FAILED' do
        expect(subject).to receive(:processed_all?).and_raise(Exceptions::FileNotProcessedException)
        subject.call
        expect(subject.contacts_file.processing_failed?).to be_truthy
      end
    end
  end
end