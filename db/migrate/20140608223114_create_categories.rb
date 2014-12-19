class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :type
      t.integer :patent_total, default: 0
      t.integer :user_total, default: 0

      t.timestamps
    end
  end
end
