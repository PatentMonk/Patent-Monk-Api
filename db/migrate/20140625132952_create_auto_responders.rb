class CreateAutoResponders < ActiveRecord::Migration
  def change
    create_table :auto_responders do |t|
      t.text :response
      t.integer :user_id

      t.timestamps
    end
  end
end
