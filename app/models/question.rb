class Question < ActiveRecord::Base
  belongs_to :author, :class_name => 'User'
  belongs_to :accepted_answer, :class_name => 'Answer'
  has_many :answers
  has_many :votes, :as => :voteable

  validates_presence_of :title, :body, :author
end
