class Question < ActiveRecord::Base
  belongs_to :author, :class_name => 'User'
  belongs_to :accepted_answer, :class_name => 'Answer'
  has_many :answers
  has_many :votes, :as => :voteable

  validates_presence_of :title, :body, :author

  def vote(voter, value)
    value = case value
      when :up: 1
      when :down: -1
      else value
    end

    votes.create(:voter => voter, :value => value)
  end

  def total_votes
    votes.map {|vote| vote.value}.reduce(:+) || 0
  end
end
