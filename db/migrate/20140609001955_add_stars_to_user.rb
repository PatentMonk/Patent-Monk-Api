class AddStarsToUser < ActiveRecord::Migration
  def change
    add_column :users, :star_score, :float, default: 0.0
  end
end
