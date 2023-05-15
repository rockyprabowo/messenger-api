# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(
      name: 'User',
      email: 'user@email.test',
      password: 'secret',
      photo_url: 'https://www.google.com/'
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a valid email' do
    subject.email = 'invalid'
    expect(subject).to_not be_valid
  end

  it 'is not valid without a valid password' do
    subject.password = '.'
    expect(subject).to_not be_valid
  end

  it 'is valid to have no photo URL' do
    subject.photo_url = nil
    expect(subject).to be_valid
  end

  describe 'associations' do
    it { should have_many(:conversations) }
    it { should have_many(:conversation_memberships) }
    it { should have_many(:chat_messages).through(:conversation_memberships) }
  end
end
