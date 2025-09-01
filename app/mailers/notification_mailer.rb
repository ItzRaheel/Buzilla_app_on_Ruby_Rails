class NotificationMailer < ApplicationMailer
    default from: 'leadflowcrm@gmail.com'

  def bug_assigned(bug, developer)
    @bug = bug
    @developer = developer
    mail(to: @developer.email, subject: "Bug Assigned: #{@bug.name}")
  end

  def project_updated(project, user )
    @project = project
    @user = user
    mail(to: @user.email, subject: "Project Updated: #{@project.name}")
  end
end

