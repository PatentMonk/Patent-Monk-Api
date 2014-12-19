class CreateActionableDates < ActiveRecord::Migration
  def change
    create_table :actionable_dates do |t|
      t.datetime :day
      t.string :action
      t.integer :user_id

      t.timestamps
    end
  end
end
