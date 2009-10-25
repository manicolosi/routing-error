class Vote < ActiveRecord::Base
  belongs_to :voteable, :polymorphic => true
  belongs_to :voter, :class_name => 'User'

  validates_inclusion_of :value, :in => [-1, 1]
  validates_presence_of :voteable, :voter
  validates_uniqueness_of :voter_id, :scope => [ :voteable_id, :voteable_type ]
end
