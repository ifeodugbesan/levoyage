class ResourcePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    user
  end

  def create?
    new?
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
    new?
  end

  def remove_upvote?
    new?
  end
end
