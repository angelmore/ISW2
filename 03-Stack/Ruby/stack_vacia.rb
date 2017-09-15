require './stack'
require './stack_no_vacia'


class StackVacia

  def push(an_object, stack)
     StackNoVacia.new stack, an_object
  end

  def pop
    raise self.class.stack_empty_error_description
  end

  def top
    raise self.class.stack_empty_error_description
  end

  def stack
    self
  end

  def empty?
    true
  end

  def self.stack_empty_error_description
    'Operacion no permitida en pila vacia'
  end

  def should_implement
    raise 'Should be implemented'
  end

end
