require 'sidekiq'

class NotificationJob < ApplicationJob
  # include Sidekiq::Job
  # queue_as :default

  def perform(action, assign_id, user_id)
    user = User.find(user_id)
 
    case action
    when "bug_assigned"
      bug = Bug.find(assign_id)
      NotificationMailer.bug_assigned(bug, user).deliver_now
    when "project_updated"
      project = Project.find(user_id)
      NotificationMailer.project_updated(project, user).deliver_now
    end
  end
end
