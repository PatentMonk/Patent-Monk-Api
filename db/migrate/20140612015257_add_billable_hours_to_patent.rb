class AddBillableHoursToPatent < ActiveRecord::Migration
  def change
    add_column :patents, :billable_hours, :decimal, default: 0.00
  end
end
