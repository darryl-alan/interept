class User < ApplicationRecord
  has_many :reports, dependent: :destroy

  before_save { self.email = email.downcase }

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 15 }

  validates :email,
            presence: true,
            length: { maximum: 100 },
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  has_secure_password
end
