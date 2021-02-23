# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contact, type: :model do
  subject { build(:contact) }
  it 'has a valid factory' do
    expect(subject).to be_valid
  end

  context 'validations' do
    it { should validate_presence_of(:dob) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:email) }
    it 'should validate presence of cc_number' do
      allow(subject).to receive(:set_cc_fields).and_return(nil)
      should validate_presence_of(:cc_number)
    end
    it { expect(subject).to allow_value(subject.phone_number).for(:phone_number) }
    it { expect(subject).not_to allow_value('+5730021344489').for(:phone_number) }
    it { expect(subject).to allow_value(subject.dob).for(:dob) }
    it { expect(subject).not_to allow_value('12/29/2014').for(:dob) }
    it { expect(subject).to allow_value(subject.cc_number).for(:cc_number) }
    it { expect(subject).not_to allow_value('12345').for(:cc_number) }
  end

  context 'associations' do
    it { expect(subject).to belong_to(:user)}
  end

  context 'callbacks' do
    it { expect(subject).to callback(:set_cc_fields).after(:validation)}
  end

  context '#set_cc_fields' do
    it 'should assign remaining fields to contact' do
      last_four= subject.cc_number.last(4)
      not_coded_cc_number = subject.cc_number
      subject.send(:set_cc_fields)
      expect(subject.franchise).to eq('visa')
      expect(subject.cc_4_digits).to eq(last_four)
      expect(subject.cc_number).not_to eq(not_coded_cc_number)
    end
  end
end
