# We use the term 'Friend' internally since it is much easier to
# understand than having "Followings" with "Followers" and "Followees".
# Friendships are not mutual.
class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => 'User'

  validates_presence_of :user, :friend
  validates_uniqueness_of :friend_id,
    :scope => [ :user_id ],
    :message => "can't befriend someone multiple times"
  validate :user_and_friend_are_not_the_same

  private

  def user_and_friend_are_not_the_same
    errors.add(:friend, "must not be the user") if friend == user
  end
end
