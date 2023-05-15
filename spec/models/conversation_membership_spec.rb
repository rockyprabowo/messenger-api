require 'rails_helper'

RSpec.describe ConversationMembership, type: :model do
  let(:user1) { create(:user) }
  let(:conversation) { create(:conversation, user: user1) }

  subject do
    described_class.new(
      user: user1,
      conversation: conversation
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a user' do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a conversation' do
    subject.conversation = nil
    expect(subject).to_not be_valid
  end

  describe 'associations' do
    it { should belong_to(:conversation) }
    it { should belong_to(:user) }
    it { should have_many(:chat_messages) }
  end
end
