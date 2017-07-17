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

   #Public methods
    def pop()
      return @stack.pop
    end

    def push(element)
      @stack << element
    end

    def is_empty?
      return @stack.size == 0
    end

    def peek
      return @stack.last
    end

    def size
      return @stack.size
    end

  end
end
