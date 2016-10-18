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
  QUERY_LEARNED = "name like :search and id in (select answer_id
    FROM results r INNER JOIN lessons l
    ON r.lesson_id = l.id AND l.user_id = :user_id)"
  QUERY_ALL = "name like :search"
  QUERY_NOT_LEARNED = "name like :search and id not in (select answer_id
    FROM results r INNER JOIN lessons l
    ON r.lesson_id = l.id AND l.user_id = :user_id)"

  scope :in_category, -> category_id do
    where category_id: category_id if category_id.present?
  end

  scope :show_all, -> user_id, search do
    where QUERY_ALL, search: "%#{search}%"
  end

  scope :learned, -> (user_id, search) do
    where QUERY_LEARNED, user_id: user_id, search: "%#{search}%"
  end

  scope :not_learned, -> (user_id, search) do
    where QUERY_NOT_LEARNED, user_id: user_id, search: "%#{search}%"
  end

  scope :search, ->(keyword, category_id) do
    where("content LIKE ? OR category_id = ?", "%#{keyword}%", "#{category_id}")
  end

  scope :search_category, ->(category_id = 0) do
    where("category_id is null OR category_id = ?", "#{category_id}")
  end

  scope :filter_category, ->(category_id = 0)do
    where("category_id = ?", "#{category_id}")
  end

  private
  def build_word_answers
    if self.new_record? && self.word_answers.size == 0
      Settings.answertimes.times {self.word_answers.build}
    end
  end

  def validate_answer
    size_correct = self.word_answers.select{|answer| answer.is_correct}.size
    if size_correct == 0
      errors.add I18n.t("validate.answer"), I18n.t("validate.number")
    end
    correct_answer_size = self.word_answers.size
    if Settings.answer_default > correct_answer_size ||
      correct_answer_size > Settings.max_answer
      errors.add t("validate.size"), t("validate.condition")
    end
  end

end
