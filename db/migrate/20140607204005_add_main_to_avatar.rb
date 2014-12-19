class AddMainToAvatar < ActiveRecord::Migration
  def change
    add_column :avatars, :main, :boolean, default: false
  end
end
