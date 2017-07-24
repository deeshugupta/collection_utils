require_relative '../heap'
module CollectionUtils
  module HeapUtils
    class MaxHeap < CollectionUtils::Heap

      private

      def exchange(element, comparor)
        temp = comparor.val
        comparor.val = element.val
        element.val = temp
        return element, comparor
      end

      def heapify(node)
        left = node.left
        right = node.right
        largest = node
        if !left.nil? && left.val >= node.val
          largest = left
        end

        if !right.nil? && right.val >= largest.val
          largest = right
        end

        if largest != node
          @incomplete_set.delete(largest)
          @incomplete_set.delete(node)
          @leaf_set.delete(largest)
          @leaf_set.delete(node)
          largest, node = exchange(largest, node)
          @incomplete_set.insert(largest) if largest.is_incomplete?
          @leaf_set.insert(largest) if largest.is_leaf?
          @incomplete_set.insert(node) if node.is_incomplete?
          @leaf_set.insert(node) if node.is_leaf?
          heapify(largest)
        end
      end

      def bubble_up(node)
        parent = node.parent
        actual_node = node
        while !parent.nil? do
          @incomplete_set.delete(parent)
          @incomplete_set.delete(actual_node)
          @leaf_set.delete(parent)
          @leaf_set.delete(actual_node)
          if parent.val < actual_node.val
            parent, actual_node = exchange(parent, actual_node)
            @incomplete_set.insert(parent) if parent.is_incomplete?
            @leaf_set.insert(parent) if parent.is_leaf?
            @incomplete_set.insert(actual_node) if actual_node.is_incomplete?
            @leaf_set.insert(actual_node) if actual_node.is_leaf?
            actual_node = parent
            parent = actual_node.parent
          else
            @incomplete_set.insert(parent) if parent.is_incomplete?
            @leaf_set.insert(parent) if parent.is_leaf?
            @incomplete_set.insert(actual_node) if actual_node.is_incomplete?
            @leaf_set.insert(actual_node) if actual_node.is_leaf?
            break
          end
        end
      end

      public
      def initialize(array = [])
        @size = 0
        @root = nil
        @incomplete_set = CollectionUtils::Set.new()
        @leaf_set = CollectionUtils::Set.new()
        array.each_with_index do |element, index|
          insert(element)
        end
      end

      def insert(element)
        node = Node.new(element)
        @size += 1
        if @root.nil?
          @root = node
          @root.level = 1
          @level = 1
          @leaf_set.insert(node)
          return
        end
        unless @incomplete_set.is_empty?
          parent_node = @incomplete_set.get
          @incomplete_set.delete(parent_node)
          if parent_node.left.nil?
            node.parent = parent_node
            node.level = parent_node.level + 1
            parent_node.left = node
            @level = node.level if node.level > @level
            bubble_up(node)
            return
          end
          if parent_node.right.nil?
            node.parent = parent_node
            node.level = parent_node.level + 1
            parent_node.right = node
            @level = node.level if node.level > @level
            bubble_up(node)
            return
          end
        end

        unless @leaf_set.is_empty?
          parent_node = @leaf_set.get
          @leaf_set.delete(parent_node)
          node.parent = parent_node
          node.level = parent_node.level + 1
          parent_node.left = node
          @level = node.level if node.level > @level
          bubble_up(node)
          return
        end
      end

      # @return element which has maximum value in heap
      def get_max
        return if is_empty?
        return root.val
      end

     # Removes the maximum value element from heap and
     # corrects the whole heap again
     # @return maximum value element
      def extract_max
        return if is_empty?
        if size == 1
          @size = 0
          value = @root.val
          @root = nil
          return value
        end
        maximum = @root.val
        @size -= 1
        node = @leaf_set.get
        replaced_value = node.val
        @leaf_set.delete(node)
        @incomplete_set.delete(node)
        parent = node.parent
        parent.left == node ? parent.left = nil : parent.right = nil
        @leaf_set.delete(parent)
        @incomplete_set.delete(parent)
        node = nil
        @incomplete_set.insert(parent) if parent.is_incomplete?
        @leaf_set.insert(parent) if parent.is_leaf?

        @leaf_set.delete(@root)
        @incomplete_set.delete(@root)
        @root.val = replaced_value
        @incomplete_set.insert(@root) if @root.is_incomplete?
        @leaf_set.insert(@root) if @root.is_leaf?
        heapify(@root)
        return maximum
      end

      alias :delete :extract_max

    end
  end
end
