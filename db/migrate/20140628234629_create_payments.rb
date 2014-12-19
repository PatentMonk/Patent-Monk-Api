class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.integer :lawyer_id
      t.integer :patent_id
      t.integer :invoice_id

      t.timestamps
    end
  end
end
