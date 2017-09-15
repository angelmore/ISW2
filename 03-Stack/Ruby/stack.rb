require './stack_vacia'
require './stack_no_vacia'

class Stack

  def initialize
    @stack = StackVacia.new
    @size = 0
  end

  def push(an_object)
    @stack = @stack.push an_object, @stack
    @size = @size + 1
  end

  def pop
    top_object_to_return = @stack.top
    @stack = @stack.stack
    @size = @size - 1
    top_object_to_return
  end

  def top
    @stack.top
  end

  def stack
    @stack
  end

  def empty?
    @stack.empty?
  end

  def size
    @size
  end

  def self.stack_empty_error_description
    'Operacion no permitida en pila vacia'
  end

end
