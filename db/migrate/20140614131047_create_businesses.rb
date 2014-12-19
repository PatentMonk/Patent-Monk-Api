class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :phone
      t.string :fax
      t.string :email
      t.integer :patents_bought
      t.integer :patents_licensed

      t.timestamps
    end
    add_index :businesses, :email, unique: true
  end
end
