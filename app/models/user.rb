class User < ApplicationRecord
  has_many :games

  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true

  # Authenticate the user
  def self.authenticate(email, password)
    user = find_by(email: email)
    return :not_found if user.nil? 
    return :invalid_password unless user.authenticate(password)
    user
  end
end
