class CreateLawyerOffers < ActiveRecord::Migration
  def change
    create_table :lawyer_offers do |t|
      t.integer :patent_id
      t.integer :lawyer_id
      t.string :note
      t.decimal :amount
      t.integer :time

      t.timestamps
    end
  end
end
