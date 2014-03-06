class User < ActiveRecord::Base
  attr_accessible :name, :password, :password_confirmation, :email, :remember_token, :favorite_events
  has_many :events, dependent: :destroy
  has_secure_password

  before_save { downcase_email }
  before_create :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8, maximum: 24 }

  def downcase_email
    if !self.email.nil?
      self.email = email.downcase
    end
  end

  def User.hash(token)
  	return Digest::SHA1.hexdigest(token.to_s)
  end

  def User.new_remember_token
  	return SecureRandom.urlsafe_base64
  end

  def add_event_to_favorites(event)
    if self.favorite_events.nil?
      update_attribute(:favorite_events, event)
    else
      unless get_favorite_events.include?(event)
        update_attribute(:favorite_events, [get_favorite_events, event].join(","))
      end
    end
  end

  def get_favorite_events
    if self.favorite_events.nil?
      return ''
    else
      puts self.favorite_events
      return self.favorite_events.split(/,/)
    end
  end

  private

	  def create_remember_token
	  	self.remember_token = User.hash(User.new_remember_token)
	  end
end
