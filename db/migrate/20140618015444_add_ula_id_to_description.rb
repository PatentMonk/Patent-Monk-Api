class AddUlaIdToDescription < ActiveRecord::Migration
  def change
    add_column :descriptions, :ula_id, :integer
  end
end
