class Conversation < ApplicationRecord
  has_many :conversation_memberships
  has_many :chat_messages
end
