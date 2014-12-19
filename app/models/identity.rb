class Identity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_for_oauth(auth)
    identity = where(provider: auth.provider, uid: auth.uid).first
    if identity.nil?
      if auth.provider == "stripe_connect"
        identity = create(uid: auth.uid, provider: auth.provider, token: auth.credentials.token, publishable_key: auth.extra.raw_info.stripe_publishable_key)
      else
        identity = create(uid: auth.uid, provider: auth.provider, token: auth.credentials.token)
      end
    end
    identity
  end
end
