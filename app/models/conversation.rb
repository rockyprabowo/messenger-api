class Conversation < ApplicationRecord
  validates :user_id, presence: true

  has_many :conversation_memberships
  has_many :chat_messages
end
