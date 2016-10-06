class User < ActiveRecord::Base
  has_many :lessons
  has_many :relationships
  has_many :activities
  before_save {self.email = email.downcase}

  validates :fullname, presence: true, length: {maximum: 255}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
end
