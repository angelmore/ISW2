require './motor_stopped'
require './motor_moving_clockwise'
require './motor_moving_counter_clockwise'

class Motor
  NOT_STOPPED = 'Motor is not stopped'
  ALREADY_STOPPED = 'Motor is already stopped'
  ALREADY_MOVING_CLOCKWISE = 'Motor is already moving clockwise'
  ALREADY_MOVING_COUNTER_CLOCKWISE = 'Motor is already moving counter clockwise'

  def initialize
    @subscriptors = []
    change_state_to_stopped
  end

  def register(subscriptor)
    @subscriptors << subscriptor
  end

  def is_stopped?
    @state.is_stopped?
  end

  def is_moving_clockwise?
    @state.is_moving_clockwise?
  end

  def is_moving_counter_clockwise?
    @state.is_moving_counter_clockwise?
  end

  def stop
    @state.stop
  end

  def stop_when_stopped
    raise Exception.new(ALREADY_STOPPED)
  end

  def stop_when_moving_clockwise
    change_state_to_stopped
  end

  def stop_when_moving_counter_clockwise
    change_state_to_stopped
  end

  def start_moving_clockwise
    @state.start_moving_clockwise
  end

  def start_moving_clockwise_when_stopped
    change_state_to_moving_clockwise
  end

  def start_moving_clockwise_when_moving_clockwise
    raise Exception.new(ALREADY_MOVING_CLOCKWISE)
  end

  def start_moving_clockwise_when_moving_counter_clockwise
    raise Exception.new(NOT_STOPPED)
  end

  def start_moving_counter_clockwise
    @state.start_moving_counter_clockwise
  end

  def start_moving_counter_clockwise_when_stopped
    change_state_to_moving_counter_clockwise
  end

  def start_moving_counter_clockwise_when_moving_clockwise
    raise Exception.new(NOT_STOPPED)
  end

  def start_moving_counter_clockwise_when_moving_counter_clockwise
    raise Exception.new(ALREADY_MOVING_COUNTER_CLOCKWISE)
  end

  private

  def inform_event
    @subscriptors.each { |subs| @state.accept(subs) }
  end

  def change_state_to_stopped
    change_state_to(MotorStopped.new(self))
    inform_event
  end

  def change_state_to_moving_clockwise
    change_state_to(MotorMovingClockwise.new(self))
    inform_event
  end

  def change_state_to_moving_counter_clockwise
    change_state_to(MotorMovingCounterClockwise.new(self))
    inform_event
  end

  def change_state_to(new_state)
    @state = new_state
  end

end
