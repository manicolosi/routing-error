require 'test_helper'

class UserUsernameTest < ActiveSupport::TestCase
  test "may contain letters and numbers" do
    user = users(:example).tap { |u| u.username = "abc123"; u.save }
    assert_nil user.errors[:username]
  end

  test "may start with numbers" do
    user = users(:example).tap { |u| u.username = "123abc"; u.save }
    assert_nil user.errors[:username]
  end

  test "may contain a hyphen" do
    user = users(:example).tap { |u| u.username = "123-abc"; u.save }
    assert_nil user.errors[:username]
  end

  test "may NOT contain underscores" do
    user = users(:example).tap { |u| u.username = "abc_123"; u.save }
    assert_not_nil user.errors[:username]
  end

  test "may NOT contain periods" do
    user = users(:example).tap { |u| u.username = "abc.123"; u.save }
    assert_not_nil user.errors[:username]
  end

  test "may NOT start with a hyphen" do
    user = users(:example).tap { |u| u.username = "-abc123"; u.save }
    assert_not_nil user.errors[:username]
  end

  test "format validation error message is correct" do
    user = users(:example).tap { |u| u.username = "!nv@alid"; u.save }
    assert_equal "may only contain letters, numbers, and hyphens (-).",
      user.errors[:username]
  end
end
