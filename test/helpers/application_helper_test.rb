require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test "full title helper" do
    assert_equal full_title,          "Company Name"
    assert_equal full_title("About"), "About | Company Name"
  end

end
