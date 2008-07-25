require 'test_helper'

class UserNotifierTest < ActionMailer::TestCase
  tests UserNotifier
  def test_forgot_password
    @expected.subject = 'UserNotifier#forgot_password'
    @expected.body    = read_fixture('forgot_password')
    @expected.date    = Time.now

    assert_equal @expected.encoded, UserNotifier.create_forgot_password(@expected.date).encoded
  end

  def test_setup_email
    @expected.subject = 'UserNotifier#setup_email'
    @expected.body    = read_fixture('setup_email')
    @expected.date    = Time.now

    assert_equal @expected.encoded, UserNotifier.create_setup_email(@expected.date).encoded
  end

end
