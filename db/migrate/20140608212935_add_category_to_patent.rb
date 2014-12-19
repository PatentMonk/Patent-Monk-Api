class AddCategoryToPatent < ActiveRecord::Migration
  def change
    add_column :patents, :category, :string, default: ''
  end
end
