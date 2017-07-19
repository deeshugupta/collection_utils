require_relative '../heap'
module CollectionUtils
  module TreeUtils
    class BST < CollectionUtils::Tree
      private
      attr_accessor :bst, :height

      public
      def initialize(arr = [])
        @heap = []
        @height = 0
        arr.each do |element|
          insert(element, root)
        end
      end

      def insert(element, node)
        if !is_empty? && node == root
          @height = 1
        end
        if is_empty?
          @height = 1
          @heap << {element: element, index: 0}
          return
        end
        @height += 1
        if element > node[:element]
          right = right(node[:index])
          if right.nil?
            parent = node[:index]
            right_in = right_index(parent)
            value = {element: element, index: right_in}
            assign_right(parent, value)
            return
          else
            insert(element, right)
            return
          end
        else
          left = left(node[:index])
          if left.nil?
            parent = node[:index]
            left_in = left_index(parent)
            value = {element: element, index: left_in}
            assign_left(parent, value)
            return
          else
            insert(element, left)
            return
          end
        end

      end

      def get_min
        return root[:element]
      end

      def is_empty?
        return @heap.empty?
      end

      def get_height
        @height
      end

    end
  end
end
