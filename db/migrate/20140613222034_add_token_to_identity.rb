class AddTokenToIdentity < ActiveRecord::Migration
  def change
    add_column :identities, :token, :string
    add_column :identities, :publishable_key, :string
  end
end
