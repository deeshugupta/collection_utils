require_relative './heap'
module CollectionUtils
  module HeapUtils
    class MinHeap < Heap

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
        smallest = node
        if !left.nil? && left[:element] < node[:element]
          smallest = left
        end

        if !right.nil? && right[:element] < smallest[:element]
          smallest = right
        end

        if smallest != node
          exchange(smallest, node)
          heapify(smallest)
        end

      end

      def min
        @heap.first
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
        i = size - 1
        node, index = parent(i)
        while i != 0 && @heap[i][:element] < node[:element] do
          exchange(@heap[i], node)
          i = index
          node, index = parent(i)
        end
      end

      def get_min
        return if is_empty?
        return min[:element]
      end

      def extract_min
        return if is_empty?
        minimum = min
        if @heap.size > 1
          last_value = @heap.last
          last_value[:index] = 0
          @heap = @heap.slice(0..@heap.size-2)
          @heap[0] = last_value
          heapify(min)
        else
          @heap =[  ]
        end

        return minimum[:element]
      end
    end
  end
end
