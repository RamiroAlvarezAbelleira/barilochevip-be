class BookingPolicy < ApplicationPolicy
  def resolve
    scope.all
  end

  def index
    true
  end

  def create?
    user&.id == 1
  end

  def update
    user&.id == 1
  end

  def show
    true
  end

  def destroy
    user&.id == 1
  end
end
