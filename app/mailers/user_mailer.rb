class UserMailer < ActionMailer::Base
  default :from => "notifications@muddpage.com"

  def custom_email(user, message, subject)
    @user = user
    @message = message
    mail(:to => user.email, :subject => subject)
  end
end
