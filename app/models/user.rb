class User < ApplicationRecord
  include ActiveModel::Serializers::JSON

  # encrypt password
  has_secure_password

  validates :email, uniqueness: true
  validates :name, presence: true

  has_many :conversations
  has_many :conversation_memberships
  has_many :chat_messages, through: :conversation_memberships

  def include_email
    as_json({ except: %i[password_digest created_at updated_at] })
  end

  def as_json(options = {})
    super({ except: %i[password_digest created_at updated_at email] }.merge(options))
  end
end
