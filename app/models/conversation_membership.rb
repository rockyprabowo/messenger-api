class ConversationMembership < ApplicationRecord
  validates :conversation, presence: true
  validates :user, presence: true

  belongs_to :conversation
  belongs_to :user
  has_many :chat_messages

  scope :current_user, -> { where(user_id: Current.user.id) }
  scope :is_a_member, -> { where(is_member: true) }
  scope :between_users, lambda { |params|
    where(user_id: params[:user_ids])
      .group!(:conversation_id)
      .having('count(distinct user_id) > ?', 1)
  }
  scope :user_conversation, lambda { |params|
    where(conversation_id: params[:conversation_id])
      .where(user_id: params[:user_id])
  }
end
