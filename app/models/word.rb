class Word < ActiveRecord::Base
  belongs_to :category
  has_many :results
  has_many :word_answers
  accepts_nested_attributes_for :word_answers, :allow_destroy => true
end
