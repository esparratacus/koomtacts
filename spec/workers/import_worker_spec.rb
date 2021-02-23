# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe ImportWorker, type: :worker do
  let(:contact_file_class) {class_double(ContactsFile, find: ContactsFile.new(attributes_for(:contacts_file)))}
  describe '#perform' do
    it 'should enqueue the new job' do
      described_class.perform_async
      expect(described_class.queue).to eq("default")
    end
  end
end
