class UserMailer < ActionMailer::Base
  default :from => "Holono"
  default_url_options[:host] = "holono.com"

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
  
  def added_user(user_to, user_from, project)
  	@user_to = user_to  
	  @user = user_from
	  @project = project
	  subject = "#{@user.name} has added you as a collaborator to #{@project.name}"
	  mail(:to => @user_to.email, :subject => subject)
  end

  def know_more(user_to, user_from, project)
    subject = "#{user_from.name} wants to know more about your project #{project.name}"
    mail(:to => user_to.email, :subject => subject)
  end
end
