class AddProvisionalToPatent < ActiveRecord::Migration
  def change
    add_column :patents, :provisional, :boolean
  end
end
