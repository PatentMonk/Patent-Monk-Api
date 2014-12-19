class AddSubscriptionIdToBilling < ActiveRecord::Migration
  def change
    add_column :billings, :subscription_id, :string
  end
end
