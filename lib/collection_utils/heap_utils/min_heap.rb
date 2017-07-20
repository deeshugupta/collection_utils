require_relative '../heap'
require_relative '../hash_deserialized_object'
module CollectionUtils
  module HeapUtils
    class MinHeap < CollectionUtils::Heap

      private
      attr_accessor :heap

      def exchange(element, comparor)
        temp = comparor.element
        comparor.element = element.element
        element.element = temp
        return element, comparor
      end

      def heapify(node)
        left = left(node.index)
        right = right(node.index)
        smallest = node
        if !left.nil? && left.element < node.element
          smallest = left
        end

        if !right.nil? && right.element < smallest.element
          smallest = right
        end

        if smallest != node
          exchange(smallest, node)
          heapify(smallest)
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
        value = CollectionUtils::HashDeserializedObject.new({element: element,
          index: size})
        @heap << value
        i = size - 1
        node, index = parent(i)
        while i != 0 && @heap[i].element < node.element do
          exchange(@heap[i], node)
          i = index
          node, index = parent(i)
        end
      end


      # @return element which has minimum value in heap
      def get_min
        return if is_empty?
        return root.element
      end

      # Removes the minimum value element from heap and
      # corrects the whole heap again
      # @return minimum value element
      def extract_min
        return if is_empty?
        minimum = root
        if @heap.size > 1
          last_value = @heap.last
          last_value.index = 0
          @heap = @heap.slice(0..@heap.size-2)
          @heap[0] = last_value
          heapify(root)
        else
          @heap =[]
        end

        return minimum.element
      end
    end
  end
end
