require './motor'
require './elevator_opened'

class CabinDoor

  CLOSED_SENSOR_MALFUNCTION = 'Funcionamiento incorrecto del sensor de puerta cerrada'
  OPENED_SENSOR_MALFUNCTION = 'Funcionamiento incorrecto del sensor de puerta abierta'

  def initialize(motor,bell)
    @motor = motor
    @bell = bell
    @state = ElevatorOpened.new self
  end

  def should_implement
    raise 'Implementar!'
  end

  #Testing state
  def is_opened?
    @state.class.name == 'ElevatorOpened'
  end

  def is_closing?
    @state.class.name == 'ElevatorClosing'
  end

  def is_opening?
    @state.class.name == 'ElevatorOpening'
  end

  def is_closed?
    @state.class.name == 'ElevatorClosed'
  end

  def motor
    @motor
  end

  #Campana
  def ring
    @bell.ring
  end

  #Boton de cerrar
  def close_button_pressed
    @state = @state.closing
  end

  #Boton de abrir
  def open_button_pressed
    @state = @state.opening
  end

  #Sensor de puerta cerrada
  def closed_sensor_activated
    @state = @state.closed
  end

  #Sensor de puerta abierta
  def opened_sensor_activated
    @state = @state.opened
  end

  #Motor
  def is_motor_stopped?
    @motor.is_stopped?
  end

  def is_motor_moving_clockwise?
    @motor.is_moving_clockwise?
  end

  def is_motor_moving_counter_clockwise?
    @motor.is_moving_counter_clockwise?
  end

end
