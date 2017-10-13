class CabinDoorConsole

  def initialize(cabin_door)
    @lines = []
    @cabin_door = cabin_door
    @cabin_door.register(self)
  end

  def lines_enumerator
    @lines.each
  end

  def visit_motor_moving_clockwise(state)
    @lines << 'Motor is moving clockwise'
  end

  def visit_motor_moving_counter_clockwise(state)
    @lines << 'Motor is moving counter clockwise'
  end

  def visit_motor_stopped(state)
    @lines << 'Motor is stopped'
  end

  def visit_cabin_door_closing(state)
    @lines << 'Door is closing'
  end

  def visit_cabin_door_closed(state)
    @lines << 'Door is closed'
  end

  def visit_cabin_door_opening(state)
    @lines << 'Door is opening'
  end

  def visit_cabin_door_opened(state)
    @lines << 'Door is opened'
  end
end
