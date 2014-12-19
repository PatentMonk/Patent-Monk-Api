class CreateSellOffers < ActiveRecord::Migration
  def change
    create_table :sell_offers do |t|
      t.integer :user_id
      t.integer :paent_id
      t.string :offer
      t.string :note
      t.boolean :user_accept, default: false
      t.boolean :business_accept, default: false

      t.timestamps
    end
  end
end
