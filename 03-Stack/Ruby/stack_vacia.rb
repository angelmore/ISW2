require './stack'
require './stack_no_vacia'


class StackVacia

  def push(an_object)
     @stack = StackNoVacia.new StackVacia.new, an_object
  end

  def pop
    raise self.stack_empty_error_description
  end

  def top
    raise self.stack_empty_error_description
  end

  def empty?
    true
  end

  def size
    0
  end

  def self.stack_empty_error_description
    'Operacion no permitida en pila vacia'
  end

  def should_implement
    raise 'Should be implemented'
  end

end
