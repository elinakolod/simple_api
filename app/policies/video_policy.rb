class VideoPolicy < ApplicationPolicy
  def create?
    true
  end

  def restart?
    record.user == user
  end

  def index?
    true
  end

  class Scope < Scope
    def resolve
      user.videos
    end
  end
end
