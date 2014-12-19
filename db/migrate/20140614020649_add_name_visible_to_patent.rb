class AddNameVisibleToPatent < ActiveRecord::Migration
  def change
    add_column :patents, :name_visible, :boolean, default: false
  end
end
