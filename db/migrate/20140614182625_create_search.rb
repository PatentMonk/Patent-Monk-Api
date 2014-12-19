class CreateSearch < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :term
      t.integer :user_id
    end
  end
end
