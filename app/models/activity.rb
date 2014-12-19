class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :trackable, polymorphic: true
  #attr_accessible :action, :trackable, :icon_type
end
