class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
    elsif user.sites.size > 0

      can :read, :all

      can :manage, Site do |site|
        user.sites.include?(site)
      end
      cannot :create, Site

      can :manage, Category do |category|
        user.sites.include? category.site
      end

      can :create, Idea
      can :create_fork, Idea
      can :manage, Idea do |idea|
        user.sites.include?(idea.site)
      end

      can :manage, User # do |u|
       #        user.sites.include?(u.site)
       #      end

      can :read, Link
      can :manage, Link do |link|
        user.sites.include?(link.site)
      end

    else
      can :read, :all

      can :create, Idea
      can :explore, Idea
      can :manage, User, :id => user.id
      can :manage, Idea do |idea|
        (idea.user_id == user.id) and (not idea.site.deadline_finished?)
      end
      can :create_fork, Idea do |idea|
        not idea.site.deadline_finished?
      end
      cannot :create_fork, Idea, :user_id => user.id
    end

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
  end
end
