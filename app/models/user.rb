class User < ApplicationRecord
  # encrypt password
  has_secure_password
  has_many :conversations
  has_many :conversation_memberships
  has_many :chat_messages, through: :conversation_memberships
end
