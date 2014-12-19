class AddHitCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :hit_count, :integer, default: 0
  end
end
