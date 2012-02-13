class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
    #
    user ||=User.new
    if user.admin?
      can :manage, :all
    elsif user.teacher?
      can :create, Question
      can [:read,:update,:destroy], Question, :course => {:users => {:id=>user.id}}
      can [:view_stats,:stop], Question, :course => {:users => {:id=>user.id}}
      can :manage, Answer, :question => {:course => {:users => {:id => user.id}}}
      can :manage, Course, :users => {:id =>user.id}
      can [:read,:update], User, :id=>user.id
      can :manage, UserSession
    elsif user.student?
      can :manage, UserSession
      can :read, Question, :course => {:users => {:id=>user.id}}
      can :read, Answer, :question => {:course => {:users => {:id => user.id}}}
      can :read, Course, :users => {:id =>user.id}
      can :manage, UserAnswer, :answer => {:question =>{:course => {:users =>{:id=>user.id}}}}
      can [:read,:update], User, :id=>user.id
    else
      can :manage, UserSession
    end
  end
end
