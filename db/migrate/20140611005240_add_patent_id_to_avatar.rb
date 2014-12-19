class AddPatentIdToAvatar < ActiveRecord::Migration
  def change
    add_column :avatars, :patent_id, :integer
  end
end
