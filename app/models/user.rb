class User < ActiveRecord::Base
  has_many :questions, :foreign_key => 'author_id'
  has_many :answers, :foreign_key => 'author_id'
  has_many :votes, :foreign_key => 'voter_id'

  acts_as_authentic

  def to_param
    username
  end

  def vote_ups
    votes.all(:conditions => "value = '1'").count
  end

  def vote_downs
    votes.all(:conditions => "value = '-1'").count
  end
end
