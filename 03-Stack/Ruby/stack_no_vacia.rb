require './stack'

class StackNoVacia < Stack

  def initialize(a_stack, an_object)
    @stack = a_stack
    @top_object = an_object
  end

  def push(an_object)
    @stack = StackNoVacia.new @stack, an_object
  end

  def pop
    top = @stack.top_object
    @stack = @stack.stack
    top
  end

  def top
    @stack.top_object
  end

  def empty?
    false
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
