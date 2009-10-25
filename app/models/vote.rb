class Vote < ActiveRecord::Base
  belongs_to :voteable, :polymorphic => true

  validates_inclusion_of :value, :in => [-1, 1]
  validates_presence_of :voteable
end
