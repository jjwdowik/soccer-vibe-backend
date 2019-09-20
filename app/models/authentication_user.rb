class AuthenticationUser < ActiveRecord::Base

  after_create :set_api_auth_token


  def set_api_auth_token
    api_auth_token = loop do
      token = SecureRandom.hex
      break token unless self.class.exists?(api_auth_token: token)
    end
    self.update_attribute(:api_auth_token, api_auth_token)
  end


end
