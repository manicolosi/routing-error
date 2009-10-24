require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  test "able to save valid answers" do
    u = User.new(:username => 'joe', :email => 'joe@example.com')
    a = Answer.new(:author => u, :body => 'The body')
    a.question = Question.new(:title => 't', :body => 'b')
    assert a.save
  end

  test "unable to save with no body" do
    a = Answer.new
    assert !a.save
    assert_equal "can't be blank", a.errors[:body]
    assert_equal "can't be blank", a.errors[:author]
  end

  test "every answer should belong to a question" do
    a = Answer.new(:body => 'The body')
    assert_raise(ActiveRecord::RecordInvalid) { a.save! }
  end
end
