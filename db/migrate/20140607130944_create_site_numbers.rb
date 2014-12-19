class CreateSiteNumbers < ActiveRecord::Migration
  def change
    create_table :site_numbers do |t|
      t.integer :hit_count, default: 0
      t.integer :total_sign_in_count, default: 0

      t.timestamps
    end
  end
end
