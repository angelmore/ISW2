require './stack_vacia'

class Stack

  def initialize
    @stack = StackVacia.new
  end

  def push(an_object)
    @stack.push an_object
  end

  def pop
    @stack.pop
  end

  def top
    @stack.top
  end

  def empty?
    should_implement
  end

  def size
    should_implement
  end

  def self.stack_empty_error_description
    should_implement
  end

  def should_implement
    raise 'Should be implemented'
  end

  end
