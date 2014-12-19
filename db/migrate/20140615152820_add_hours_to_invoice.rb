class AddHoursToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :hours, :decimal, default: 0.00
    add_column :invoices, :paid, :boolean, default: false
  end
end
