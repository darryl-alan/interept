class Category < ApplicationRecord
  has_many :report_categories
  has_many :reports, through: :report_categories

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
end
