class Conversation < ActiveRecord::Base

  has_many :messengers
  accepts_nested_attributes_for :messengers
  belongs_to :user
end
