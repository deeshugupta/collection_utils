module CollectionUtils
  class Queue
    private
    attr_accessor :queue

    public
    #Constructors

    def initialize(array=[])
      @queue = []
      array.each do |element|
        enqueue(element)
      end
    end

    #Public Methods

    def enqueue(element)
      @queue << element
    end

    def dequeue
      element = @queue.first
      @queue = @queue.slice(1..-1)
      return element
    end

    def front
      return @queue.first
    end

    def rear
      return @queue.last
    end

    def is_empty?
      return @queue.size == 0
    end

    def size
      return @queue.size
    end

  end
end
