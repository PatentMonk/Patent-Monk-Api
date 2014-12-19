class AddUidToUser < ActiveRecord::Migration
  def change
    add_column :users, :facebook_token, :text
    add_column :users, :twitter_token, :text
    add_column :users, :linked_in_token, :text
    add_column :users, :facebook_expires_at, :datetime
    add_column :users, :twitter_expires_at, :datetime
    add_column :users, :linked_in_expires_at, :datetime
  end
end
