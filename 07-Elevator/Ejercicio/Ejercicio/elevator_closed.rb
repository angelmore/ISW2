require './elevator_state'
require './elevator_opening'

class ElevatorClosed < ElevatorState
  def closing
    @cabin_door.ring
    self
  end

  def opening
    @cabin_door.opening_when_closed
    @cabin_door.ring
    ElevatorOpening.new @cabin_door
  end

  def opened
    raise Exception, CabinDoor::OPENED_SENSOR_MALFUNCTION
  end

  def closed
    raise Exception, CabinDoor::CLOSED_SENSOR_MALFUNCTION
  end
end
