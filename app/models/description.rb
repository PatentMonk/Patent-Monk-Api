class Description < ActiveRecord::Base
  belongs_to :user
  belongs_to :patent
end
