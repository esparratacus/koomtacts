# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContactsFile, type: :model do
  subject { build(:contacts_file) }
  it 'has a valid factory' do
    expect(subject).to be_valid
  end
  describe 'validations' do
    it { should validate_presence_of(:contacts_csv) }
    it { should validate_presence_of(:status) }
  end

end
