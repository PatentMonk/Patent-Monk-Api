class RemoveUserParams < ActiveRecord::Migration
  def change
    remove_column :users, :avatar_id
    remove_column :users, :address_type
    remove_column :users, :img_url
    remove_column :users, :stripe_id
  end
end
