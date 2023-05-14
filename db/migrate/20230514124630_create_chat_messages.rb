class CreateChatMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_messages do |t|
      t.belongs_to :conversation_membership, foreign_key: true
      t.text :body
      t.timestamps
    end
  end
end
