require './elevator_state'
require './elevator_closing'

class ElevatorOpened < ElevatorState
  def closing
    @cabin_door.motor.start_moving_clockwise
    @cabin_door.ring
    ElevatorClosing.new @cabin_door
  end

  def opening
    @cabin_door.ring
    self
  end

  def closed
    raise Exception, CabinDoor::CLOSED_SENSOR_MALFUNCTION
  end

  def opened
    raise Exception, CabinDoor::OPENED_SENSOR_MALFUNCTION
  end
end
