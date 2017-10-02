require './elevator_state'
require './elevator_opening'
require './elevator_closed'

class ElevatorClosing < ElevatorState
  def closing
    @cabin_door.ring
    self
  end

  def opening
    @cabin_door.opening_when_closing
    @cabin_door.ring
    ElevatorOpening.new @cabin_door
  end

  def opened
    raise Exception, CabinDoor::OPENED_SENSOR_MALFUNCTION
  end

  def closed
    @cabin_door.stop_motor
    @cabin_door.ring
    ElevatorClosed.new @cabin_door
  end
end
