require 'test_helper'

class ContactNewTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "Contact us sends message to admin" do
    get contact_us_path
    assert_template "contacts/new"
    assert_difference 'Contact.count', 1 do
      post contacts_path, params: {
                            contact: {
                              name: "David",
                              email: "david.test@example.com",
                              message: "I had an issue"
                            },
                          }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_template "contacts/thanks"
  end
end
