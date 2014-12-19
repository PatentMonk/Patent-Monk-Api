class CreateFileOffers < ActiveRecord::Migration
  def change
    create_table :file_offers do |t|
      t.integer :user_id
      t.integer :patent_id
      t.string :offer
      t.string :note
      t.boolean :user_accept, default: false
      t.boolean :lawyer_accept, default: false

      t.timestamps
    end
  end
end
