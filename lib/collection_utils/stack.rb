module CollectionUtils
  class Stack
    private
    attr_accessor :stack

    public
    #Constructors
    def initialize(array=[])
      @stack = []
      array.each do |element|
        @stack << element
      end
    end

    # Pop will remove the top element from the stack and return the
    # removed element.
    # @return Top element of the stack
    #
    # @example Create a stack [1,2,3,4,5] and remove 5 using pop
    #   stack = CollectionUtils::Stack.new([1,2,3,4,5])
    #   top_element = stack.pop() # top_element = 5, stack = [1,2,3,4]
    def pop
      return @stack.pop
    end


    # Add the element to the stack using push
    #
    # @param element that needs to added to stack. This element will the top element
    # @example Create a stack [1,2,3,4,5] and add 6 to it.
    #   stack = CollectionUtils::Stack.new([1,2,3,4,5])
    #   stack.push(6)
    #   #stack will be [1,2,3,4,5,6]
    def push(element)
      @stack << element
    end

    # @return [Boolean] stack's emptiness
    # @example Create a stack [1,2,3,4,5] and add check emptiness.
    #   stack = CollectionUtils::Stack.new([1,2,3,4,5])
    #   stack.is_empty? # false
    def is_empty?
      return @stack.size == 0
    end

    # View the top element of the stack without removing it
    #
    # @return Top element of the stack
    #
    # @example Create a stack [1,2,3,4,5] and get 5 using peek
    #   stack = CollectionUtils::Stack.new([1,2,3,4,5])
    #   top_element = stack.peek # top_element = 5, stack = [1,2,3,4,5]
    def peek
      return @stack.last
    end

    # @return [Integer] size of stack
    # @example Create a stack [1,2,3,4,5] and check size.
    #   stack = CollectionUtils::Stack.new([1,2,3,4,5])
    #   stack.size # 5
    def size
      return @stack.size
    end

  end
end
