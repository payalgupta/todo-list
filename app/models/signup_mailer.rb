class SignupMailer < ActionMailer::Base

  def confirm(user, password)
    subject      = 'Registration Confirmation'
    recipients   = user.email
    from         = 'todolist@vinsol.com'
    sent_on      = Time.now
    body["user"] = user
    body["password"] = password
  end

end
