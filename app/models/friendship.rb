# We use the term 'Friend' internally since it is much easier to
# understand than having "Followings" with "Followers" and "Followees".
# Friendships are not mutual.
class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => 'User'

  validates_presence_of :user, :friend
end
