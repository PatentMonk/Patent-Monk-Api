class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :first_user_id
      t.integer :second_user_id
      t.string :conversation_subject

      t.timestamps
    end
  end
end
