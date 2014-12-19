class CreateMessengers < ActiveRecord::Migration
  def change
    create_table :messengers do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.text :message
      t.boolean :trash, default: false
      t.boolean :seen, default: false
      t.boolean :notify_seen, default: false
      t.attachment :attachment

      t.timestamps
    end
  end
end
