require 'test_helper'

class SignupMailerTest < ActionMailer::TestCase
  tests SignupMailer
  def test_confirm
    @expected.subject = 'SignupMailer#confirm'
    @expected.body    = read_fixture('confirm')
    @expected.date    = Time.now

    assert_equal @expected.encoded, SignupMailer.create_confirm(@expected.date).encoded
  end

  def test_sent
    @expected.subject = 'SignupMailer#sent'
    @expected.body    = read_fixture('sent')
    @expected.date    = Time.now

    assert_equal @expected.encoded, SignupMailer.create_sent(@expected.date).encoded
  end

end
