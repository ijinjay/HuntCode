class User < ActiveRecord::Base
  has_many :projects
  has_many :stars
  has_one :thirdparty
  has_many :projects, :through=> :stars
  has_many :projects, :through=> :comments
  before_save { self.x_email = x_email.downcase }
  before_create :create_remember_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i


  validates :x_username, presence: true, length: { maximum: 20 }
  validates :x_email, presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
