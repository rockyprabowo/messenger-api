# frozen_string_literal: true

class MessagesController < ApplicationController
  include Authorization
  before_action :target_user_exists

  def create
    if user_had_conversation_with @target_user
      send_to_existing_conversation
      json_response new_message_response, :created
      return
    end
    send_new_conversation_to @target_user
    json_response new_message_response, :created
  end

  private

  def target_user_exists
    @target_user = User.find(params[:user_id])
  end

  def user_had_conversation_with(user)
    @existing_id = ConversationMembership
                   .between_users(user_ids: [Current.user.id, user.id])
                   .pluck(:conversation_id)
                   .first

    return false if @existing_id.blank?

    obtain_user_membership
    true
  end

  def obtain_user_membership
    @membership_id = ConversationMembership
                     .user_conversation(conversation_id: @existing_id, user_id: Current.user.id)
                     .pluck(:id)
                     .first
  end

  def send_to_existing_conversation
    @new_message = send_message(
      @existing_id, @membership_id, params[:message]
    )
  end

  def send_new_conversation_to(user)
    create_conversation_between(Current.user.id, user.id)
    @new_message = send_message(@new_conversation.id, @new_membership.id, params[:message])
  end

  def create_conversation_between(creator_id, *user_ids)
    ActiveRecord::Base.transaction do
      @new_conversation = Conversation.create!(user_id: creator_id)
      @new_membership = ConversationMembership.create!(conversation_id: @new_conversation.id, user_id: creator_id)
      ConversationMembership.create!(user_ids.map do |id|
        { conversation_id: @new_conversation.id, user_id: id }
      end)
    end
  end

  def send_message(conversation_id, membership_id, body)
    ChatMessage.create!(
      conversation_id: conversation_id,
      conversation_membership_id: membership_id,
      body: body
    )
  end

  def new_message_response
    @new_message.include_message
  end
end
