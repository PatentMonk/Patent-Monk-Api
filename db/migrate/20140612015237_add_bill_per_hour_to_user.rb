class AddBillPerHourToUser < ActiveRecord::Migration
  def change
    add_column :users, :bill_per_hour, :decimal, default: 0.00
  end
end
