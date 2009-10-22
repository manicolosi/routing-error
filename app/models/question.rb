class Question < ActiveRecord::Base
  belongs_to :author, :class_name => 'User'
  has_many :answers

  validates_presence_of :title, :body, :author
end
