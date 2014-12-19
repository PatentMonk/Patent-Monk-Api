class AddParamsToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :paid, :boolean, default: false
    add_column :payments, :amount, :decimal, default: 0.00
    add_column :payments, :payment_date, :timestamp
  end
end
