class CreatePotentials < ActiveRecord::Migration
  def change
    create_table :potentials do |t|
      t.string :full_name
      t.string :email
      t.string :telephone
      t.text :message

      t.timestamps
    end
  end
end
