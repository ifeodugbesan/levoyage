class IssuePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def new?
    user
  end

  def create?
    new?
  end

  def edit?
    record.user == user || user&.admin
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  def upvote?
    new?
  end

  def remove_upvote?
    new?
  end
end
