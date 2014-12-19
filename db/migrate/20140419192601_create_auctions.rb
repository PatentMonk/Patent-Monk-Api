class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :patent_id
      t.decimal :price
      t.decimal :auction_price
      t.integer :business_won
      t.integer :business_winning
      t.boolean :paid, default: false
      t.datetime :finish_date

      t.timestamps
    end
  end
end
