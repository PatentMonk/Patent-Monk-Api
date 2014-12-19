class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :payer_id
      t.integer :payee_id
      t.decimal :pay_amount, default: 0.00
      t.integer :patent_id
      t.string :file_or_sell, default: "File"

      t.timestamps
    end
  end
end
