# frozen_string_literal: true

class ConversationsController < ApplicationController
  includes NeedsAuthorization

  def index
    conversations_ids = ConversationMembership.where(user_id: Current.user.id)
                                              .distinct
                                              .pluck(:conversation_id)

    conversations = Conversation.includes(conversation_memberships: :user)
                                .where(conversations_ids)
                                .order(created_at: :desc)
    json_response conversations
  end

  def show
    conversation = Conversation.find params[:id]
    json_response conversation
  end

  def messages
    messages = ChatMessage.includes(conversation_membership: :user)
                          .where(conversation_id: params[:id])
                          .order(created_at: :desc)
    json_response messages
  end
end
