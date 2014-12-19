class AddVerifyTokenToPotentials < ActiveRecord::Migration
  def change
    add_column :potentials, :verify_token, :string
    add_column :potentials, :verified, :boolean, default: false
  end
end
