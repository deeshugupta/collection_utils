require_relative './heap'
module CollectionUtils
  module HeapUtils
    class MaxHeap < Heap

      private
      attr_accessor :heap

      def exchange(element, comparor)
        temp = comparor[:element]
        comparor[:element] = element[:element]
        element[:element] = temp
        return element, comparor
      end

      def heapify(node)
        left = left_child(node[:index]).first
        right = right_child(node[:index]).first
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

      def max
        @heap.first
      end

      public
      def initialize(array = [])
        @heap = []
        array.each_with_index do |element, index|
          value = {element: element, index: index}
          if @heap.empty?
            @heap << value
            next
          end
          insert(value)
        end
      end

      def insert(value)
        @heap << value
        i = @heap.size - 1
        node, index = parent(i)
        while i != 0 && @heap[i][:element] >= node[:element] do
          exchange(@heap[i], node)
          i = index
          node, index = parent(i)
        end
      end

      def get_max
        return if is_empty?
        return max[:element]
      end

      def extract_max
        return if is_empty?
        maximum = max
        if @heap.size > 1
          last_value = @heap.last
          last_value[:index] = 0
          @heap = @heap.slice(0..@heap.size-2)
          @heap[0] = last_value
          heapify(max)
        else
          @heap =[  ]
        end

        return maximum[:element]
      end
    end
  end
end
