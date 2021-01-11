class User < ApplicationRecord
  before_save { self.email = email.downcase } # change user email to downcase before save in DB
  has_many :articles
  validates :user_name, presence: true, length: {minimum: 3, maximum: 50}

  VALID_EMAIL_REGEX = /\A[a-z0-9\+\-_\.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: { case_sensitive: false },
            length: {maximum: 105}, format: { with: VALID_EMAIL_REGEX }


end