class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.float :number
      t.integer :user_id
      t.integer :master_id

      t.timestamps
    end
  end
end
