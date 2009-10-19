require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "able to save valid questions" do
    q = Question.new(:title => 'The Title', :body => 'The body')
    assert q.save
  end

  test "unable to save invalid questions" do
    q = Question.new

    assert !q.save
    assert_equal "can't be blank", q.errors[:title]
    assert_equal "can't be blank", q.errors[:body]
  end
end
