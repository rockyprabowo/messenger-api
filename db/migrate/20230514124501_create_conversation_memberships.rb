class CreateConversationMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :conversation_memberships do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :conversation, foreign_key: true
      t.boolean :is_member
      t.timestamp :last_accessed_at
      t.timestamps
    end
  end
end
