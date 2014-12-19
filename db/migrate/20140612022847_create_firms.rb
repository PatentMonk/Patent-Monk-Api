class CreateFirms < ActiveRecord::Migration
  def change
    create_table :firms do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :phone
      t.string :fax
      t.string :email

      t.timestamps
    end
  end
end
