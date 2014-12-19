class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :request_type
      t.string :mood
      t.integer :user_id
      t.text :msg

      t.timestamps
    end
  end
end
