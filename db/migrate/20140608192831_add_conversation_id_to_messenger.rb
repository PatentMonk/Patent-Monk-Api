class AddConversationIdToMessenger < ActiveRecord::Migration
  def change
    add_column :messengers, :conversation_id, :integer
  end
end
