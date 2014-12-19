class AddPhoneAndNamesToUser < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :firm_name, :string
    add_column :users, :business_name, :string
    add_column :users, :job_title, :string
    add_column :users, :middle_name, :string
    add_column :users, :firm_id, :integer
    add_column :users, :business_id, :integer
  end
end
