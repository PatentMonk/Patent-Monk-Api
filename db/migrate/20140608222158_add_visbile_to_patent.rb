class AddVisbileToPatent < ActiveRecord::Migration
  def change
    add_column :patents, :visible, :boolean, default: true
  end
end
