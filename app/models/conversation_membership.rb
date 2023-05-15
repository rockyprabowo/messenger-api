class ConversationMembership < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  has_many :chat_messages
end
