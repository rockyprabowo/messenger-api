class ChatMessage < ApplicationRecord
  include ActiveModel::Serializers::JSON

  validates :conversation_id, presence: true
  validates :conversation_membership_id, presence: true
  validates :body, presence: true

  belongs_to :conversation_membership
  belongs_to :conversation
  has_one :user, through: :conversation_membership

  default_scope { order(created_at: :desc, updated_at: :desc) }
end
