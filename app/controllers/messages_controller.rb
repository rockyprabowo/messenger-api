# frozen_string_literal: true

class MessagesController
  def create
    if on_existing_conversation_with(params[:user_id])
      new_message = ChatMessage.create(
        conversation_id: @existing.conversation_id,
        conversation_membership_id: @membership.id,
        body: params[:message]
      )
      json_response new_message
    end
  end

  private

  def on_existing_conversation_with(user_id)
    @existing = ConversationMembership.pluck(:conversation_id)
                                      .between([Current.user.id, user_id])
                                      .first

    @membership = ConversationMembership.pluck(:id)
                                        .of(@existing.conversation_id, Current.user.id)
                                        .first
  end

  def create_conversation_between(creator_id, *user_ids)
    ActiveRecord::Base.transaction do
      conversation = Conversation.create(user_id: creator_id)
      ConversationMembership.create(conversation_id: conversation.id, user_id: creator_id)
      ConversationMembership.create(user_ids.map do |id|
        { conversation_id: conversation.id, user_id: id }
      end)
    end
  end
end
