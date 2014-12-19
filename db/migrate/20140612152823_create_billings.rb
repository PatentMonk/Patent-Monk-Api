class CreateBillings < ActiveRecord::Migration
  def change
    create_table :billings do |t|
      t.string :stripe_id
      t.integer :user_id

      t.timestamps
    end
  end
end
