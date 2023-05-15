class ChatMessage < ApplicationRecord
  validates :conversation_id, presence: true
  validates :conversation_membership_id, presence: true
  validates :body, presence: true

  belongs_to :conversation_membership
  belongs_to :conversation
end
