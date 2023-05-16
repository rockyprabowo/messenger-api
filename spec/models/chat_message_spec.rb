require 'rails_helper'

RSpec.describe ChatMessage, type: :model do
  let(:user1) { create(:user) }
  let(:conversation1) { create(:conversation, user: user1) }
  let(:membership) do
    create(:conversation_membership, user: user1, conversation: conversation1)
  end

  subject do
    described_class.new(
      body: 'Hello, world!',
      conversation: conversation1,
      conversation_membership: membership
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a message/body' do
    subject.body = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a conversation' do
    subject.conversation = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a conversation membership' do
    subject.conversation_membership = nil
    expect(subject).to_not be_valid
  end

  describe 'associations' do
    it { should belong_to(:conversation_membership) }
    it { should belong_to(:conversation) }
    it { should have_one(:user).through(:conversation_membership) }
  end
end
