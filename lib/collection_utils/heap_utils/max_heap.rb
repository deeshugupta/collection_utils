require_relative '../heap'
module CollectionUtils
  module HeapUtils
    class MaxHeap < CollectionUtils::Heap

      private
      attr_accessor :heap

      def exchange(element, comparor)
        temp = comparor[:element]
        comparor[:element] = element[:element]
        element[:element] = temp
        return element, comparor
      end

      def heapify(node)
        left = left(node[:index])
        right = right(node[:index])
        largest = node
        if !left.nil? && left[:element] >= node[:element]
          largest = left
        end

        if !right.nil? && right[:element] >= largest[:element]
          largest = right
        end

        if largest != node
          exchange(largest, node)
          heapify(largest)
        end

      end

      public
      def initialize(array = [])
        @heap = []
        array.each_with_index do |element, index|
          insert(element)
        end
      end

      def insert(element)
        value = {element: element, index: size}
        @heap << value
        i = @heap.size - 1
        node, index = parent(i)
        while i != 0 && @heap[i][:element] >= node[:element] do
          exchange(@heap[i], node)
          i = index
          node, index = parent(i)
        end
      end

      # @return element which has maximum value in heap
      def get_max
        return if is_empty?
        return root[:element]
      end

     # Removes the maximum value element from heap and
     # corrects the whole heap again
     # @return maximum value element
      def extract_max
        return if is_empty?
        maximum = root
        if @heap.size > 1
          last_value = @heap.last
          last_value[:index] = 0
          @heap = @heap.slice(0..@heap.size-2)
          @heap[0] = last_value
          heapify(root)
        else
          @heap =[  ]
        end

        return maximum[:element]
      end
    end
  end
end
