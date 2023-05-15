# frozen_string_literal: true

class ConversationsController < ApplicationController
  include Authorization

  before_action :validate_conversation_access, only: %i[show messages]

  def index
    load_conversations
    json_response conversations_response
  end

  def show
    load_conversation
    json_response conversation_response
  end

  def messages
    load_messages
    touch_accessed_at
    json_response messages_response
  end

  private

  def load_conversations
    @conversations = Conversation
                     .includes(:conversation_memberships, chat_messages: :user)
                     .where(
                       id: ConversationMembership
                             .current_user.is_a_member
                             .distinct
                             .pluck(:conversation_id)
                     )
  end

  def load_conversation
    @conversation = Conversation.find(@conversation_id)
  end

  def load_messages
    @messages = ChatMessage.includes(:user)
                           .where(conversation_id: @conversation_id)
  end

  def validate_conversation_access
    conversation = Conversation.find(params[:id])
    @conversation_id = conversation.id if owner?(conversation) do |c|
      c.authorize_with_user_id Current.user.id
    end
  end

  def touch_accessed_at
    membership = ConversationMembership.where(conversation_id: @conversation_id)
                                       .current_user
                                       .first
    return unless membership.present?

    membership.last_accessed_at = Time.now
    membership.save!
  end

  def conversations_response
    @conversations
  end

  def conversation_response
    @conversation.as_json({ except: %i[unread_count last_message user_id created_at updated_at] })
  end

  def messages_response
    @messages.map(&:include_message)
  end
end
