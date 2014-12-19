class Potential < ActiveRecord::Base

  before_create :generate_token

  protected

  def generate_token
    self.verify_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.exists?(verify_token: random_token)
    end
  end
end
