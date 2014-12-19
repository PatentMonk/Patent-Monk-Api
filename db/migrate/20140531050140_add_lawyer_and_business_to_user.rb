class AddLawyerAndBusinessToUser < ActiveRecord::Migration
  def change
    add_column :users, :lawyer, :boolean, default: false
    add_column :users, :business, :boolean, default: false
  end
end
