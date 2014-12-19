class CreateAvatars < ActiveRecord::Migration
  def change
    create_table :avatars do |t|
      t.string :img_url
      t.integer :user_id
      t.integer :business_id
      t.integer :lawyer_id
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
