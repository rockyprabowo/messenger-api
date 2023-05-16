class Conversation < ApplicationRecord
  include ActiveModel::Serializers::JSON

  attribute :with_user
  attribute :unread_count
  attribute :last_message

  validates :user_id, presence: true

  has_many :conversation_memberships
  has_many :users, through: :conversation_memberships
  has_many :chat_messages
  belongs_to :user

  def authorize_with_user_id(user_id)
    self.user_id == user_id ||
      conversation_memberships
        .select { |cm| cm.user_id == user_id }
        .first
        .present?
  end

  def id_and_with_user
    {
      id: id,
      with_user: with_user
    }
  end

  def with_user
    users.reject { |m| m.id == Current.user.id }
         .first || Current.user
  end

  def last_message
    chat_messages.first
  end

  def unread_count
    chat_messages.where('updated_at >= ? AND updated_at <= NOW()', last_user_access_time)
                 .count
  end

  def as_json(options = {})
    super({ except: %i[user_id created_at updated_at] }.merge(options))
  end

  private

  def last_user_access_time
    conversation_memberships.select { |m| m.user_id == Current.user.id }
                            .first
                            .last_accessed_at
  end
end
