class WordAnswer < ActiveRecord::Base
  belongs_to :word
  has_many :results
end
