class Result < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :question, class_name: :Word
  belongs_to :word_answer
  delegate :is_correct, to: :word_answer, allow_nil: true

  QUERY = "INNER JOIN word_answers ON results.question_id =
    word_answers.word_id AND results.answer_id = word_answers.id"

  scope :in_lesson, -> (lesson) {where lesson_id: lesson.id}
  scope :correct, -> {joins(QUERY).merge(WordAnswer.correct)}
end
