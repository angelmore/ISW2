require './motor'

class CabinDoor

  CLOSED_SENSOR_MALFUNCTION = 'Funcionamiento incorrecto del sensor de puerta cerrada'
  OPENED_SENSOR_MALFUNCTION = 'Funcionamiento incorrecto del sensor de puerta abierta'

  OPENING = 1
  CLOSING = 2
  OPENED = 3
  CLOSED = 4

  def initialize(motor,bell)
    @motor = motor
    @bell = bell
    @state = OPENED
  end

  def should_implement
    raise 'Implementar!'
  end

  #Testing state
  def is_opened?
    @state == OPENED
  end

  def is_closing?
    @state == CLOSING
  end

  def is_opening?
    @state == OPENING
  end

  def is_closed?
    @state == CLOSED
  end

  #Campana
  def ring
    @bell.ring
  end

  #Boton de cerrar
  def close_button_pressed
    @motor.stop unless @motor.is_stopped?
    @motor.start_moving_clockwise
    @state = CLOSING
    ring
  end

  #Boton de abrir
  def open_button_pressed
    @motor.stop unless @motor.is_stopped?
    @motor.start_moving_counter_clockwise
    @state = OPENING
    ring
  end

  #Sensor de puerta cerrada
  def closed_sensor_activated
    raise Exception, CLOSED_SENSOR_MALFUNCTION unless is_closing?
    @state = CLOSED
    @motor.stop
  end

  #Sensor de puerta abierta
  def opened_sensor_activated
    raise Exception, OPENED_SENSOR_MALFUNCTION unless is_opening?
    @state = OPENED
    @motor.stop
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
