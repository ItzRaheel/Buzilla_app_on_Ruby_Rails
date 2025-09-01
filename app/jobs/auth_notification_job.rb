require 'sidekiq'
class AuthNotificationJob < ApplicationJob

# include Sidekiq::Job
    # debugger
#   queue_as :default

  def perform(action, user_id)
    user = User.find(user_id)

    case action
    when "signup"
      UserMailer.welcome_email(user).deliver_now
    when "login"
      UserMailer.login_notification(user).deliver_now
    end
  end
end
