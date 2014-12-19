class CreateHintBoxes < ActiveRecord::Migration
  def change
    create_table :hint_boxes do |t|
      t.string :page
      t.integer :user_id

      t.timestamps
    end
  end
end
