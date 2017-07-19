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

    # Enqueue will add an element in queue.
    # The added element can be seen through rear function call
    #
    # @param element to be added in queue
    # @example Add element in queue
    #   queue = CollectionUtils::Queue.new()
    #   queue.enqueue(1)
    #   queue.enqueue([1,3,4,])
    def enqueue(element)
      @queue << element
    end

    # Dequeue will remove element from queue and return the value
    #
    # @return element that has been removed
    # @example delete element from queue
    #   queue = CollectionUtils::Queue.new()
    #   queue.enqueue(1)
    #   queue.enqueue([1,3,4,])
    #   element = queue.dequeue #element = 1
    def dequeue
      element = @queue.first
      @queue = @queue.slice(1..-1)
      return element
    end


    # @return element that has been recently added
    def front
      return @queue.first
    end

    # @return element that will be dequeued next
    def rear
      return @queue.last
    end

    # @return [Boolean] which tells queue's emptiness
    def is_empty?
      return @queue.size == 0
    end

    # @return [Integer] size of queue
    def size
      return @queue.size
    end

  end
end
