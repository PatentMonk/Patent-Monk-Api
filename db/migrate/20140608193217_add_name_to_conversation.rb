class AddNameToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :first_user_name, :string
    add_column :conversations, :second_user_name, :string
  end
end
