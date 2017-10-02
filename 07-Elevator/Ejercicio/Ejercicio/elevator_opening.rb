require './elevator_state'
require './elevator_opened'
require './elevator_closing'

class ElevatorOpening < ElevatorState
  def closing
    @cabin_door.closing_when_opening
    @cabin_door.ring
    ElevatorClosing.new @cabin_door
  end

  def opening
    @cabin_door.ring
    self
  end

  def opened
    @cabin_door.stop_motor
    @cabin_door.ring
    ElevatorOpened.new @cabin_door
  end

  def closed
    raise Exception, CabinDoor::CLOSED_SENSOR_MALFUNCTION
  end
end
