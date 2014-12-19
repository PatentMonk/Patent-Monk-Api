class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.text :message
      t.integer :user_id

      t.timestamps
    end
  end
end
