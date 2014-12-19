class Patent < ActiveRecord::Base
  has_one :user
  accepts_nested_attributes_for :user
  belongs_to :users
  has_one :description
  accepts_nested_attributes_for :description
  has_many :avatars
  accepts_nested_attributes_for :avatars, allow_destroy: true
  has_many :lawyer_offers
  accepts_nested_attributes_for :lawyer_offers
  belongs_to :invoice

  after_commit :callback_description, :on => :create

  private
  
  def callback_description
    Description.create(patent_id: self.id)
  end
end