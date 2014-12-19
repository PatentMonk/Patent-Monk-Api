class AddLiveToPatent < ActiveRecord::Migration
  def change
    add_column :patents, :live, :boolean, default: false
  end
end
