class AddMonthlyOrFeeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :monthly_or_fee, :string
  end
end
