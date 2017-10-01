require './elevator_state'
require './elevator_opened'
require './elevator_closing'

class ElevatorOpening < ElevatorState
  def closing
    @cabin_door.motor.stop
    @cabin_door.motor.start_moving_clockwise
    @cabin_door.ring
    ElevatorClosing.new @cabin_door
  end

  def opening
    @cabin_door.ring
    self
  end

  def opened
    @cabin_door.motor.stop
    @cabin_door.ring
    ElevatorOpened.new @cabin_door
  end

  def closed
    raise Exception, CabinDoor::CLOSED_SENSOR_MALFUNCTION
  end
end
