class AddTagsToPatent < ActiveRecord::Migration
  def change
    add_column :patents, :tags, :string, default: ''
  end
end
