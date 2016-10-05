class User < ActiveRecord::Base
  has_many :lessons
  has_many :relationships
  has_many :activities
end
