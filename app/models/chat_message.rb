class ChatMessage < ApplicationRecord
  belongs_to :conversation_membership
  belongs_to :conversation
end
