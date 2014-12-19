class AddParamsToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :subtotal, :decimal, default: 0.00
    add_column :invoices, :fee, :decimal, default: 0.00
    add_column :invoices, :note, :string
  end
end
