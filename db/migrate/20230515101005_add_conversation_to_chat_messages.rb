class AddConversationToChatMessages < ActiveRecord::Migration[6.1]
  def change
    add_reference :chat_messages, :conversation, null: false, foreign_key: true
  end
end
