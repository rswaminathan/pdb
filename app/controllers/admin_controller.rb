class AdminController < ApplicationController
    
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

    def feedback
      email = ["rswaminathan@hmc.edu", "Ozzie_Gooen@hmc.edu"]
      message = ""
      params[:feedback].each do |key, value|
        message += "#{key}: #{value} \n"
      end
      email.each do |e|
      UserMailer.feedback(message, e).deliver
      end
    end
end
