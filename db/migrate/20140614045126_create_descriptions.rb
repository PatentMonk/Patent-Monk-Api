class CreateDescriptions < ActiveRecord::Migration
  def change
    create_table :descriptions do |t|
      t.integer :patent_id
      t.integer :user_id
      t.text :description

      t.timestamps
    end
  end
end
