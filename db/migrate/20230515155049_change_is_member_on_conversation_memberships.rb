class ChangeIsMemberOnConversationMemberships < ActiveRecord::Migration[6.1]
  def change
    change_column_default :conversation_memberships, :is_member, true
  end
end
