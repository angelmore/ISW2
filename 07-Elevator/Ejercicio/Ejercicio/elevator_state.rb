require './cabin_door'

class ElevatorState
  def initialize(cabin_door)
    @cabin_door = cabin_door
  end

  def closing
    should_implement
  end

  def opening
    should_implement
  end

  def opened
    should_implement
  end

  def closed
    should_implement
  end
end
