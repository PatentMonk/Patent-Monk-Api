class AddLawyerAcceptToPatent < ActiveRecord::Migration
  def change
    add_column :patents, :lawyer_accept, :string, default: ''
  end
end
