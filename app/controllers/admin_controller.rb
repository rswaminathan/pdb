class AdminController < ApplicationController
    
  before_filter :admin_user?
    def email
      @users = User.all
    end
    
    def send_email
      @users = User.all
      @subject = params[:email][:subject]
      @message = params[:email][:message]
      @users.each do |u|
      UserMailer.custom_email(u, @message, @subject).deliver
      end
    end 

    def email_one
      @users = User.all
      if !params[:email].nil?
        @user = User.find(params[:email][:id])
        @subject = params[:email][:subject]
        @message = params[:email][:message]
        UserMailer.custom_email(@user, @message, @subject).deliver
        render :text => "Email sent"   
       end
    end

    def feedback
      email = ["rswaminathan@hmc.edu", "Ozzie_Gooen@hmc.edu", "mattmcdermott8@gmail.com"]
      message = ""
      params[:feedback].each do |key, value|
        message += "#{key}: #{value} \n"
      end
      email.each do |e|
      UserMailer.feedback(message, e).deliver
      end
    end

end
