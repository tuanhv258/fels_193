class Word < ActiveRecord::Base

  include Sort

  belongs_to :category
  has_many :results
  has_many :word_answers , dependent: :destroy

  validates :name, presence: true, length: {maximum: 255}
  validate :validate_answer
  accepts_nested_attributes_for :word_answers, allow_destroy: true,
    reject_if: proc{|attributes| attributes["content"].blank?}
  after_initialize :build_word_answers

  private
  def build_word_answers
    if self.new_record? && self.word_answers.size == 0
      Settings.answertimes.times {self.word_answers.build}
    end
  end

  def validate_answer
    size_correct = self.word_answers.select{|answer| answer.is_correct}.size
    if size_correct == 0
      errors.add t("validate.answer"), t("validate.0")
    end
    correct_answer_size = self.word_answers.size
    if Settings.answer_default > correct_answer_size ||
      correct_answer_size > Settings.max_answer
      errors.add t("validate.size"), t("validate.condition")
    end
  end
end
