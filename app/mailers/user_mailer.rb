class UserMailer < ApplicationMailer
      default from: 'raheelzafar605@gmail.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Bugzilla App!")
  end

  def login_notification(user)
    @user = user
    mail(to: @user.email, subject: "New Login Detected")
  end
end
