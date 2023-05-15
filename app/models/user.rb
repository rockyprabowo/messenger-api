class User < ApplicationRecord
  include ActiveModel::Serializers::JSON

  # encrypt password
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP,
                                                                message: 'must be a valid e-mail' }
  validates :name, presence: true, length: { minimum: 2 }
  validates :password, presence: true, length: { in: 6..32 }

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
