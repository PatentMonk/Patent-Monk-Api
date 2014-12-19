class CreatePatents < ActiveRecord::Migration
  def self.up
    create_table :patents do |t|
      t.string :name
      t.integer :user_id
      t.integer :lawyer_id
      t.integer :business_id
      t.string :patent_number
      t.boolean :created, default: false
      t.boolean :selling, default: false
      t.string :url
      t.timestamps
    end
  end

  def self.down
    drop_table :patents
  end
end
