class Category < ActiveRecord::Base

  include Sort

  has_many :lessons
  has_many :words

  validates :title, presence: true, length: {maximum: 255}
  validates :detail, presence: true, length: {maximum: 255}
end
