class AddNameToMessenger < ActiveRecord::Migration
  def change
    add_column :messengers, :sender_user_name, :string
    add_column :messengers, :receiver_user_name, :string
  end
end
