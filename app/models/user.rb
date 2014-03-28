class User < ActiveRecord::Base
  attr_reader :password

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :password_digest, presence: true


  before_validation :set_session_token

  def self.find_by_credentials(email, secret)
    user = User.find_by_email(email)

    if user.nil?
      nil
    elsif user.is_password?(secret)
      user
    else
      nil #WRONG PASSWORD BUDDY!
    end
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def set_session_token
    self.session_token || reset_session_token!
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def password=(secret)
    return if secret.blank?#rails check for nil or ""
    @password = secret
    self.password_digest = BCrypt::Password.create(secret)

    #write_attribute(attr_name, value)
  end

  def is_password?(secret)
    BCrypt::Password.new(self.password_digest).is_password?(secret)
  end

end
