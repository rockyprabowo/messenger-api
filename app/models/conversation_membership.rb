class ConversationMembership < ApplicationRecord
  belongs_to :conversation
  has_many :chat_messages
end
