class User < ActiveRecord::Base
  has_many :questions, :foreign_key => 'author_id'
  has_many :answers, :foreign_key => 'author_id'
  has_many :votes, :foreign_key => 'voter_id'

  has_many :friendships
  has_many :friends, :through => :friendships

  acts_as_authentic

  def vote_for(voteable)
    conditions = "voteable_id = '#{voteable.id}' AND " +
                 "voteable_type = '#{voteable.class}'"
    votes.first(:conditions => conditions)
  end

  def vote_ups
    votes.all(:conditions => "value = '1'").count
  end

  def vote_downs
    votes.all(:conditions => "value = '-1'").count
  end

  def recent_activity(limit = 10)
    options = { :order => 'created_at DESC', :limit => 10 }
    recent = [ :questions, :answers ].map { |stream| send stream }
    recent = recent.flatten
    recent = recent.sort { |a, b| b.created_at <=> a.created_at }
    recent.take(options[:limit])
  end

  def reputation
    votes_for = Vote.all.select { |vote| vote.voteable.author == self }
    votes_for.inject(0) do |acc, vote|
      acc += (vote.value == 1 ? 10 : -2)
    end
  end
end
