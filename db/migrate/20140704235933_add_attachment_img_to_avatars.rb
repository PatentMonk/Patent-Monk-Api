class AddAttachmentImgToAvatars < ActiveRecord::Migration
  def self.up
    change_table :avatars do |t|
      t.attachment :img
    end
  end

  def self.down
    drop_attached_file :avatars, :img
  end
end
