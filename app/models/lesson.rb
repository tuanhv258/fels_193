class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy
  has_many :words, through: :results
  has_many :word_answers, through: :results
  accepts_nested_attributes_for :results

  def count_correct_answers
    if self.is_complete?
      Result.correct.in_lesson(self).count
    end
  end

  def score
    "#{self.count_correct_answers}/
      #{self.results.count}"
  end
end
