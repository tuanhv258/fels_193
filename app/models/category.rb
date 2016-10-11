class Category < ActiveRecord::Base
  has_many :lessons
  has_many :words
  validates :title, presence: true
  validates :detail, presence: true
end
