require './stack'

class StackNoVacia

  def initialize(a_stack, an_object)
    @stack = a_stack
    @top_object = an_object
  end

  def push(an_object, a_stack)
    StackNoVacia.new a_stack, an_object
  end

  def top
    @top_object
  end

  def stack
    @stack
  end

  def empty?
    false
  end
end
