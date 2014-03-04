class User < ActiveRecord::Base
  attr_accessible :name, :password, :password_confirmation, :email, :remember_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false }
  validates :password, length: { minimum: 8, maximum: 24 }

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  def User.hash(token)
  	return Digest::SHA1.hexdigest(token.to_s)
  end

  def User.new_remember_token
  	return SecureRandom.urlsafe_base64
  end

  private

	  def create_remember_token
	  	self.remember_token = User.hash(User.new_remember_token)
	  end
end
