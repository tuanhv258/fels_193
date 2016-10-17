class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :results

  def score
    "#{self.results.select{|result| result if result.is_correct}.count}/
      #{self.results.count}"
  end
end
