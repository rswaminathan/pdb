class UserMailer < ActionMailer::Base
  default :from => "notifications@muddpage.com"
  default_url_options[:host] = "muddpage.com"

  def custom_email(user, message, subject)
    @user = user
    @message = message
    mail(:to => user.email, :subject => subject)
  end

  def invite_user(email, user, project)
    @user = user
    @project = project
    subject = "#{user.name} has invited you as a collaborator to #{project.name}"
    mail(:to => email, :subject => subject)
  end

  def feedback(text)
    @text = text
    mail(:to => "rswaminathan@hmc.edu", :subject => "Got feedback")
    mail(:to => "Ozzie_Gooen@hmc.edu", :subject => "Got feedback")
  end
end
