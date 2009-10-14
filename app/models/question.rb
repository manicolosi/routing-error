class Question < ActiveRecord::Base
  has_many :answers

  validates_presence_of :title, :body

  def answer_count
    "#{answers.count} answers"
  end
end
