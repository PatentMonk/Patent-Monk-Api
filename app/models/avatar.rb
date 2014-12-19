class Avatar < ActiveRecord::Base
  has_attached_file :img, use_timestamp: false
  do_not_validate_attachment_file_type :img

  belongs_to :patent
  belongs_to :user
end
