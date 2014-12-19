class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :confirmable
         
  has_many :tickets, dependent: :destroy
  accepts_nested_attributes_for :tickets
  has_many :activities, dependent: :destroy
  accepts_nested_attributes_for :activities
  has_many :identities, dependent: :destroy
  accepts_nested_attributes_for :identities
  has_many :stars, dependent: :destroy
  accepts_nested_attributes_for :stars
  has_one :description, dependent: :destroy
  accepts_nested_attributes_for :description, :update_only => true
  has_many :avatar, dependent: :destroy
  accepts_nested_attributes_for :avatar
  has_one :billing, dependent: :destroy
  accepts_nested_attributes_for :billing
  has_many :hint_boxes, dependent: :destroy
  accepts_nested_attributes_for :hint_boxes
  has_one :notice, dependent: :destroy
  accepts_nested_attributes_for :notice, :update_only => true
  has_one :auto_responder, dependent: :destroy
  accepts_nested_attributes_for :auto_responder, :update_only => true
  belongs_to :patents
  has_many :patents, dependent: :destroy
  accepts_nested_attributes_for :patents
  has_many :conversations, dependent: :destroy
  accepts_nested_attributes_for :conversations
  has_many :messengers, through: :conversations, dependent: :destroy
  accepts_nested_attributes_for :messengers

  def lawyer?
    self.lawyer
  end

  def business?
    self.business
  end

  def self.user_lawyer_search(page)
    return User.joins("left outer join avatars on avatars.user_id = users.id and avatars.main = true")
    .joins("left outer join billings on billings.user_id = users.id")
    .joins("join identities on identities.user_id = users.id and 
            identities.provider = 'stripe_connect'")
    .joins(:description)
    .select("users.*, avatars.img_url, billings.stripe_id, identities.provider, 
            descriptions.description as descriptions")
    .where(lawyer: true)
    .where("(users.monthly_or_fee = 'monthly' and identities.provider IS NOT NULL and billings.stripe_id 
            IS NOT NULL) OR (users.monthly_or_fee = 'fee' and identities.provider IS NOT NULL)")
    .paginate(page: page, per_page: 12)
  end

  def self.user_business_search(page)
    User.joins("left outer join avatars on avatars.user_id = users.id and avatars.main = true")
    .select("users.*, avatars.img_url")
    .where(business: true)
    .paginate(page: page, per_page: 12)
  end

  def self.user_patent_search(page,bool)
    User.joins("left outer join avatars on avatars.user_id = users.id and avatars.main = true")
    .joins("join patents on patents.user_id = users.id and patents.created = #{bool} and 
      patents.selling = #{bool}")
    .select("users.*, avatars.img_url")
    .paginate(page: page, per_page: 16)
  end

  def self.ula_search(page,current_user) 
    User.joins("join ulas on ulas.lawyer_id = #{current_user.id}")
    .joins("left outer join avatars on avatars.user_id = users.id and avatars.main = true")
    .joins("JOIN patents on patents.user_id = users.id AND patents.lawyer_id = #{current_user.id}")
    .select("COUNT(patents.id) as patent_length, users.*, avatars.img_url, 
      descriptions.description as descriptions")
    .joins(:description)
    .where("users.id = ulas.user_id AND users.id != #{current_user.id}")
    .group("users.id,avatars.img_url,descriptions.description")
    .paginate(page: page, per_page: 16)
  end

  def self.pending_ulas(current_user)
    u =User.joins("join ulas on ulas.lawyer_id = #{current_user.id}")
    .select("COUNT(ulas.id) as ulas_length")
    .where("users.id = ulas.user_id AND users.id != #{current_user.id} ulas.patent_id IS NULL")
    return u.ulas_length rescue 0
  end

  private
  def build_callback_description
    Description.create(user_id: self.id)
    # This should only be for lawyers, but to make sure there aren't any errors ever, going to make it for all types.
    # Possible future use for non lawyer users
      Notice.create(user_id: self.id)
      AutoResponder.create(user_id: self.id)
    # End
  end
end
