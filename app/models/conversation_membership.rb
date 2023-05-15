class ConversationMembership < ApplicationRecord
  validates :conversation_id, presence: true
  validates :user_id, presence: true

  belongs_to :conversation
  belongs_to :user
  has_many :chat_messages

  scope :between, lambda { |users|
    where(user_id: users)
      .group!(:conversation_id)
      .having('count(distinct :user_id) > ?', 1)
  }

  scope :of, lambda { |conversation_id, user_id|
    where(conversation_id: conversation_id).where(user_id: user_id)
  }

  scope :member, -> { where(is_member: true) }
end
