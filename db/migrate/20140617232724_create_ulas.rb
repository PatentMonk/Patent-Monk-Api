class CreateUlas < ActiveRecord::Migration
  def change
    create_table :ulas do |t|
      t.integer :patent_id
      t.integer :user_id
      t.integer :lawyer_id
      t.boolean :lawyer_accept

      t.timestamps
    end
  end
end
