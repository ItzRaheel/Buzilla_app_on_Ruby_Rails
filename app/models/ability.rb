# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    #
    if user.role == "Manger"
      can :manage, :all
    elsif user.role == "developer"
      can :read, :Bug ,Project: {users: {id:user.id}}
      can :assign_self,Bug do |bug|
        bug.developer_id.nill? ||bug.developer_id == user.id
      end
      cannot :read ,[Report]
      # can :update ,Bug 

      can [:update,:read],[Bug,Project]
    elsif user.role == "QA"
      can :read ,[Bug,Project,Report]
      can :manage ,[Report]

    else
      can :read ,:all

    end
# if user.role == "Manger"
#       can :manage, :all
#     # else user.role? :developer
#     else 
#       can :read, :all
#     end


    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?  can :manage, Post

    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
