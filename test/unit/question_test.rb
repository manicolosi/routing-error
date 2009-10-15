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

  test "answer count with no answers" do
    q = Question.new
    assert_equal '0 answers', q.answer_count
  end

  test "answer count with one answers" do
    q = Question.new(:title => 'The Title', :body => 'The body')
    Answer.create(:question => q, :body => 'Test answer #3')
    q.save!

    #assert_equal '1 answer', q.answer_count
  end

  test "answer count with some answers" do
    q = Question.new(:title => 'The Title', :body => 'The body')
    Answer.create(:question => q, :body => 'Test answer #3')
    Answer.create(:question => q, :body => 'Test answer #3')
    Answer.create(:question => q, :body => 'Test answer #3')
    q.save!

    assert_equal '3 answers', q.answer_count
  end
end
