require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  test "can only vote +1 or -1" do
    [ -2, 0, 2 ].each do |n|
      vote = Vote.create(:value => n)
      assert_equal "is not included in the list", vote.errors[:value]
    end

    [ -1, 1 ].each do |n|
      vote = Vote.create(:value => n)
      assert_equal nil, vote.errors[:value]
    end
  end

  test "voting requres a voteable" do
    v = Vote.new(:value => 1)
    assert v.invalid?
    assert_equal "can't be blank", v.errors[:voteable]
  end

  test "voting requires a voter" do
    vote = Vote.create

    assert_equal "can't be blank", vote.errors[:voter]

    vote.voter = users(:example)
    vote.save

    assert_equal nil, vote.errors[:voter]
  end

  test "a user cannot vote multiple times for the same voteable" do
    asker = users(:question_author)
    user = users(:example)

    # Asker asks a question
    question = questions(:example)
    question.author = asker

    # Another user tries to up-vote it twice
    user.votes.create!(:voteable => question, :value => 1)
    vote = user.votes.create(:voteable => question, :value => 1)

    assert_equal "can't vote multiple times", vote.errors[:voter_id]
  end

  test "a user can vote on an answer to their question" do
    asker = users(:question_author)
    answerer = users(:answer_author)

    # Asker asks a question
    question = questions(:example)
    question.author = asker

    # Answerer answers asker's question
    answer = answers(:example)
    answer.question = question
    answer.author = answerer

    # Asker up-votes answerer's answer
    vote = asker.votes.build(:voteable => answer, :value => 1)

    assert vote.valid?
  end

  test "a user cannot vote on their own voteable" do
    asker = users(:question_author)
    question = questions(:example)
    question.author = asker

    vote = asker.votes.build(:voteable => question, :value => 1)

    assert vote.invalid?
    assert_equal "voter can't be the author", vote.errors[:voter]
  end
end
