require 'test_helper'

class ApplicationHelperTest < ActiveSupport::TestCase
  include ApplicationHelper

  test "html_id is formatted correctly" do
    id = questions(:example).id
    assert_equal "question-#{id}", html_id(questions(:example))
  end
end
