class ChatMessage < ApplicationRecord
  include ActiveModel::Serializers::JSON

  attribute :message
  attribute :sender
  attribute :sent_at

  validates :conversation_id, presence: true
  validates :conversation_membership_id, presence: true
  validates :body, presence: true

  belongs_to :conversation_membership
  belongs_to :conversation
  has_one :user, through: :conversation_membership

  default_scope { order(created_at: :desc, updated_at: :desc) }

  def include_message
    as_json({ except: %i[conversation_membership_id conversation_id body created_at updated_at] })
  end

  def sender
    {
      id: user.id,
      name: user.name
    }
  end

  def message
    body
  end

  def sent_at
    created_at
  end

  def as_json(options = {})
    super(
      { except: %i[conversation_membership_id conversation_id body message created_at updated_at] }.merge(options)
    )
  end
end
