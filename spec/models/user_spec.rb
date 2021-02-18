require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }
  it 'has a valid factory' do
    expect(subject).to be_valid
  end

  context 'Associations' do
    it { is_expected.to have_many(:contacts) }
    it { is_expected.to have_many(:contacts_files) }
  end
end
