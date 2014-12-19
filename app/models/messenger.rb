class Messenger < ActiveRecord::Base
  has_attached_file :attachment, use_timestamp: false
  do_not_validate_attachment_file_type :attachment
  belongs_to :conversation
end
