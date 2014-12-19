class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :address, :string
    add_column :users, :address_two, :string
    add_column :users, :city, :string
    add_column :users, :fax, :string
    add_column :users, :phone_type, :string
    add_column :users, :fax_type, :string
    add_column :users, :country, :string
    add_column :users, :address_type, :string
  end
end
