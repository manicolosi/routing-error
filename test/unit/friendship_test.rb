require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  test "new users have no friends" do
    assert_equal 0, users(:example).friends.count
  end

  test "can create friendships" do
    Friendship.create(:user => users(:example), :friend => users(:example2))

    assert_equal users(:example2), users(:example).friends[0]
  end

  test "are not mutual" do
    Friendship.create(:user => users(:example), :friend => users(:example2))

    assert_equal 0, users(:example2).friends.count
  end

  test "a user cannot follow itself" do
    friendship = Friendship.create(:user => users(:example),
      :friend => users(:example))

    assert_equal "must not be the user", friendship.errors[:friend]
  end

  test "a user cannot follow another user twice" do
    Friendship.create(:user => users(:example),
      :friend => users(:example2))
    friendship = Friendship.create(:user => users(:example),
      :friend => users(:example2))

    assert_equal "can't befriend someone multiple times",
      friendship.errors[:friend_id]
  end
end

