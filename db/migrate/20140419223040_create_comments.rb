class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :patent_id
      t.text :content
      t.integer :business_id
      t.integer :lawyer_id
      t.integer :user_id

      t.timestamps
    end
  end
end
