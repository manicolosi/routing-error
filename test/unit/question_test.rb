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
end
