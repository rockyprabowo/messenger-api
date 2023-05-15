require 'rails_helper'

RSpec.describe Conversation, type: :model do
  let(:user) { create(:user) }

  subject do
    described_class.new(
      user_id: user.id
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a user' do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:conversation_memberships) }
    it { should have_many(:users).through(:conversation_memberships) }
    it { should have_many(:chat_messages) }
  end
end
