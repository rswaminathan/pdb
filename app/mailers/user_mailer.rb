class UserMailer < ActionMailer::Base
  default :from => "Muddpage"
  default_url_options[:host] = "muddpage.com"

  def custom_email(user, message, subject)
    @user = user
    @message = message
    mail(:to => user.email, :subject => subject)
  end

  def invite_user(email, user, project)
    @user = user
    @project = project
    @email = email
    subject = "#{@user.name} has invited you as a collaborator to #{@project.name}"
    mail(:to => email, :subject => subject)
  end

  def feedback(text, email)
    @text = text
    mail(:to => email, :subject => "Got feedback")
  end
end
