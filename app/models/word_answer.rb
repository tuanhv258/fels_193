class WordAnswer < ActiveRecord::Base
  belongs_to :word
  has_many :results

  validates :content, presence: true, length: {maximum: 255}
end
