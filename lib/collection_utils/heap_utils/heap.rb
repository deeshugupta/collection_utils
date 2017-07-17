module CollectionUtils
  module HeapUtils
    class Heap
      private
      attr_accessor :heap

      public
      #Constructors
      def initialize(array = [])
        @heap = array
      end

       #Public methods
       def root
         return @heap.first
       end

       def push(element)
         @heap << element
       end

       def pop
         element = @heap.pop
         return element
       end

       def left_child(parent = 0)
         left = (2*parent + 1)
         return nil, nil if @heap[left].nil?
         return @heap[left], left
       end

       def right_child(parent = 0)
         right = (2*parent + 2)
         return nil, nil if @heap[right].nil?
         return @heap[right], right
       end

       def parent(child = 0)
         par = child/2
         return @heap[par], par
       end

       def size
         return @heap.size
       end

       def is_empty?
         return @heap.size == 0
       end

       def bfs
         queue = CollectionUtils::Queue.new
         queue.enqueue({element: @heap.first, index: 0})
         while true do
           node = queue.dequeue
           break if node.nil?
           left = left_child(node[:index])
           right = right_child(node[:index])
           yield(node[:element]) if block_given?
           queue.enqueue({element: left.first, index: left.last}) if !left.first.nil?
           queue.enqueue({element: right.first, index: right.last}) if !right.first.nil?
           break if left.first.nil? && right.first
         end

       end

       def dfs
         stack = CollectionUtils::Stack.new
         stack.push({element: @heap.first, index: 0})
         while true do
           node = stack.pop
           break if node.nil?
           left = left_child(node[:index])
           right = right_child(node[:index])
           yield(node[:element]) if block_given?
           stack.push({element: left.first, index: left.last}) if !left.first.nil?
           stack.push({element: right.first, index: right.last}) if !right.first.nil?
           break if left.first.nil? && right.first
         end

       end

    end
    Tree = Heap
  end
end
