class AlternativePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    user
  end

  def edit?
    record.user == user
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  def upvote?
    create?
  end

  def remove_upvote?
    create?
  end
end
