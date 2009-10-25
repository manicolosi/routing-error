require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  test "can only vote +1 or -1" do
    u = User.new(:username => 'joe', :email => 'joe@example.com')
    q = Question.new(:author => u, :title => 'The Title', :body => 'The body')

    bill = User.new(:username => 'bill', :email => 'bill@example.com')

    [ -2, 0, 2 ].each do |n|
      v = Vote.new(:voteable => q, :voter => bill, :value => n)
      assert v.invalid?
    end

    [ -1, 1 ].each do |n|
      v = Vote.new(:voteable => q, :voter => bill, :value => n)
      assert v.valid?
    end
  end

  test "not valid without an associated voteable" do
    v = Vote.new(:value => 1)
    assert v.invalid?
    assert_equal "can't be blank", v.errors[:voteable]
  end

  test "creating a vote requires a voter" do
    a = User.new(:username => 'joe', :email => 'joe@example.com')
    q = Question.new(:author => a, :title => 'The Title', :body => 'The body')
    v = Vote.new(:voteable => q, :value => 1)

    assert v.invalid?
    assert "can't be blank", v.errors[:voter]

    v.voter = User.new(:username => 'bill', :email => 'bill@example.com')

    assert v.valid?
  end

  test "a user cannot vote multiple times" do
    a = User.new(:username => 'joe', :email => 'joe@example.com')
    q = Question.new(:author => a, :title => 'The Title', :body => 'The body')

    bill = User.new(:username => 'bill', :email => 'bill@example.com')

    v = Vote.new(:voter => bill, :voteable => q, :value => 1)
    assert v.valid?
    v.save

    v = Vote.new(:voter => bill, :voteable => q, :value => 1)
    assert v.invalid?
  end
end
