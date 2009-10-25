require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "able to save valid questions" do
    u = User.new(:username => 'joe', :email => 'joe@example.com')
    q = Question.new(:author => u, :title => 'The Title', :body => 'The body')
    assert q.save
  end

  test "unable to save invalid questions" do
    q = Question.new

    assert !q.save
    assert_equal "can't be blank", q.errors[:title]
    assert_equal "can't be blank", q.errors[:body]
    assert_equal "can't be blank", q.errors[:author]
  end

  test "can be voted on" do
    u = User.new(:username => 'joe', :email => 'joe@example.com')
    q = Question.create(:author => u, :title => 'The Title', :body => 'The body')

    bill = User.create(:username => 'bill', :email => 'bill@example.com',
      :password => "none", :password_confirmation => "none")
    ted = User.create(:username => 'ted', :email => 'ted@example.com',
      :password => "none", :password_confirmation => "none")

    assert_equal 0, q.total_votes

    q.vote(bill, :up)
    q.vote(ted, :down)

    assert_equal 2, q.votes.count
    assert_equal 0, q.total_votes
  end
end
