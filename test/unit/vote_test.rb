require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  test "can only vote +1 or -1" do
    u = User.new(:username => 'joe', :email => 'joe@example.com')
    q = Question.create(:author => u, :title => 'The Title', :body => 'The body')

    [ -2, 0, 2 ].each do |n|
      v = Vote.create(:voteable => q, :value => n)
      assert v.invalid?
    end

    [ -1, 1 ].each do |n|
      v = Vote.create(:voteable => q, :value => n)
      assert v.valid?
    end
  end

  test "only valid of associated with a voteable" do
    v = Vote.create(:value => 1)
    assert v.invalid?
    assert_equal "can't be blank", v.errors[:voteable]
  end
end
