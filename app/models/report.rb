class Report < ApplicationRecord
  belongs_to :user

  has_many :report_categories
  has_many :categories, through: :report_categories

  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 5, maximum: 100 }
end
