class User < ActiveRecord::Base
  has_many :questions, :foreign_key => 'author_id'
  has_many :answers, :foreign_key => 'author_id'

  acts_as_authentic

  def to_param
    username
  end
end
