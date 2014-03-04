class User < ActiveRecord::Base
  attr_accessible :name, :password, :password_confirmation, :email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false }
  validates :password, length: { minimum: 8, maximum: 24 }

  before_save { self.email = email.downcase }
end
