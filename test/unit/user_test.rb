require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "a username cannot contain periods" do
    user = users(:example)
    user.username = "joe.user"

    assert user.invalid?
    assert_equal "should use only letters, numbers, spaces, and -_@ please.",
      user.errors[:username]
  end

  test "a new user has zero reputation ponts" do
    user = users(:example)
    assert_equal 0, user.reputation
  end

  test "an upvote is worth 10 reputation points" do
    user = users(:question_author)
    question = questions(:example)
    question.author = user
    question.save

    voter = users(:example)
    voter.votes.create!(:voteable => question, :value => 1)

    assert_equal 10, user.reputation
  end

  test "an downvote is worth -2 reputation points" do
    user = users(:question_author)
    question = questions(:example)
    question.author = user
    question.save

    voter = users(:example)
    voter.votes.create!(:voteable => question, :value => -1)

    assert_equal -2, user.reputation
  end

  test "2 upvotes and 2 downvotes is worth 16 reputation points" do
    user = users(:question_author)
    4.times do
      question = questions(:example).clone
      question.author = user
      question.save
    end

    voter = users(:example)
    user.questions[0, 2].each do |question|
      voter.votes.create!(:voteable => question, :value => 1)
    end
    user.questions[2, 2].each do |question|
      voter.votes.create!(:voteable => question, :value => -1)
    end

    assert_equal 16, user.reputation
  end
end
