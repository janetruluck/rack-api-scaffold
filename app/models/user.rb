class User < ActiveRecord::Base
  include BCrypt

  attr_accessible :email, :verified

  validates :uuid, :email, :encrypted_password, :auth_token, presence: true
  validates :uuid, :email, :auth_token, uniqueness: true

  before_validation :generate_uuid, :generate_auth_token

  def self.authenticate(token)
    find_by_auth_token(token)
  end

  def password
    @password ||= Password.new(encrypted_password)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.encrypted_password = @password
  end

  private
  def generate_uuid
    self.uuid ||= SecureRandom.uuid.gsub("-", "")
  end

  def generate_auth_token
    self.auth_token ||= SecureRandom.uuid.gsub("-", "")
  end
end
