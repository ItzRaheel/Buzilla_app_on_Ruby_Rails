class BugPolicy < ApplicationPolicy
  def create?
    user.role == "Manger"
    # new?
  end
  # def new?
  # end
  # def index?
  #   if user.role == "Manger"
  #     record.project.user_id == user.id
  #   elsif user.role == "developer"
  #     true

  #   elsif user.role == "QA" 
  #     true
  #     else 
  #       false
  #     end
  #   end


  # def assign?
  #   user.role == "developer" && user.projects.include?(bug.project)
  # end

  # def resolve?
  #   user.role == "developer" && bug.developer_id == user.id
  # end
  def assign?
    user.role == "developer" && record.project.developer_id == user.id
    end
    def resolve?
      user.role == "developer" && record.assign_id == user.id
    end
    def show? 
      if user.role == "Manger"
        record.project.user_id == user.id
      elsif user.role == "developer"
        record.project.developer_id == user.id
      elsif user.role == "QA"
        true
        else
          false 
        end
      end
      def destroy?
        user.role == "Manger"
        end
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  class Scope < ApplicationPolicy::Scope

    def resolve 
      if user.role == "Manger"
        scope.joins(:project).where(projects: {user_id: user.id})
      elsif user.role == "developer"
        scope.joins(:project).where(projects:{developer_id: user.id})
      elsif user.role == "QA"
        scope.all
      else
        scope.none
      end
    end
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
