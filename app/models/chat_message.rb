class ChatMessage < ApplicationRecord
  belongs_to :conversation_membership
end
