class Answer < ActiveRecord::Base
  belongs_to :author, :class_name => 'User'
  belongs_to :question
  has_many :votes, :as => :voteable

  validates_presence_of :question, :body, :author

  def accepted?
    question.accepted_answer == self
  end
end
