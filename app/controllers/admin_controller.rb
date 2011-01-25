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
      UserMailer.feedback(params[:feedback]).deliver
    end
end
