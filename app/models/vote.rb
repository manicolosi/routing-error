class Vote < ActiveRecord::Base
  belongs_to :voteable, :polymorphic => true
  belongs_to :voter, :class_name => 'User'

  validates_inclusion_of :value, :in => [-1, 1]
  validates_presence_of :voteable, :voter
  validates_uniqueness_of :voter_id, :scope => [ :voteable_id, :voteable_type ]
  validate :voter_is_not_voteable_author

  def self.vote(voter, voteable, value)
    value = case value
      when :up: 1
      when :down: -1
      else value
    end

    Vote.create(:voter => voter, :voteable => voteable, :value => value)
  end

  def self.votes_score_for(voteable)
    voteable.votes.map { |vote| vote.value }.reduce(:+) || 0
  end

  protected

  def voter_is_not_voteable_author
    if voteable && voter_id == voteable.author_id
      errors.add(:voter, "can't vote for its own item")
    end
  end
end
