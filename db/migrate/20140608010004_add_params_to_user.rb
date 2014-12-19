class AddParamsToUser < ActiveRecord::Migration
  def change
    add_column :users, :sell_patent, :boolean, default: false
    add_column :users, :new_patent, :boolean, default: false
  end
end
