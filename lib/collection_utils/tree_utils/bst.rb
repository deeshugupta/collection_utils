require_relative '../heap'
module CollectionUtils
  module TreeUtils
    class BST < CollectionUtils::Tree
      private

      def delete_node(element, node)
        if element == node.val
          @size -= 1
          @leaf_set.delete(node)
          # if the node is leaf then add the parent to leaf set if
          # parent.is_leaf? and assign the left or right to nil based on
          # where the node is attached to the parent.
          if node.is_leaf?
            parent = node.parent
            @leaf_set.delete(parent)
            parent.left == node ? parent.left = nil : parent.right = nil
            @leaf_set.insert(parent) if parent.is_leaf?
            return
          # if the right child is leaf for the node then exchange the value of
          # right child and node and delete the right child.
          elsif node.right.is_leaf?
            node.val = node.right.val
            node.right = nil
            @leaf_set.insert(node) if node.is_leaf?
            return
            # if the left child is leaf for the node then exchange the value of
            # left child and node and delete the left child.
          elsif node.left.is_leaf?
            node.val = node.left.val
            node.left = nil
            @leaf_set.insert(node) if node.is_leaf?
            return
          else
            # find the smallest child on the right side and exchange the
            # value with the node. Balance the tree accordingly.
            smallest = find_smallest(node.right)
            if smallest.is_leaf?
              @leaf_set.delete(smallest)
              node.val = smallest.val
              @leaf_set.insert(node) if node.is_leaf?
            else
              if smallest == smallest.parent.left
                smallest.parent.left = smallest.right
                node.val = smallest.val
                smallest = nil
              else
                smallest.parent.right = smallest.right
                node.val = smallest.val
                smallest = nil
              end
            end

          end
        elsif element > node.val
          delete_node(element, node.right)
        else
          delete_node(element, node.left)
        end
      end

      def find_smallest(node)
        smallest = node.val
        left = node.left
        while left != nil do
          smallest = left.val
          left = left.left
        end
        return smallest
      end

      def find_largest(node)
        largest = node.val
        right = node.right
        while right != nil do
          largest = right.val
          right = right.right
        end
        return largest
      end

      def insert_node(node, parent_node)
        if node.val >= parent_node.val
          if parent_node.right.nil?
            @leaf_set.delete(parent_node)
            parent_node.right = node
            node.level = parent_node.level + 1
            @level = node.level if node.level > @level
            @leaf_set.insert(node) if node.is_leaf?
            return
          else
            insert_node(node, parent_node.right)
          end
        else
          if parent_node.left.nil?
            @leaf_set.delete(parent_node)
            parent_node.left = node
            node.level = parent_node.level + 1
            @level = node.level if node.level > @level
            @leaf_set.insert(node) if node.is_leaf?
            return
          else
            insert_node(node, parent_node.left)
          end
        end
      end

      public
      def initialize(arr = [])
        @size = 0
        @root = nil
        @incomplete_set = CollectionUtils::Set.new()
        @leaf_set = CollectionUtils::Set.new()
        arr.each do |element|
          insert(element)
        end
      end

      # Insert would insert the next element in BST according to
      # BST properties that is if element added is less than the parent_node
      # then element will be at left side of the node else will be on the right
      # side of the node. This operation is in O(logn)
      # @param element Element which needs to be added to BST
      # @example if tree has values [5,2,3,4]
      # => @bst = CollectionUtils::TreeUtils::BST.new([5,2,3,4])
      # => # BST would look like this
      # => #    5
      # => #   /
      # => #  2
      # => #   \
      # => #    3
      # => #     \
      # => #      4
      # => @bst.insert(6)
      # => # Now BST would look like this
      # => #    5
      # => #   / \
      # => #  2   6
      # => #   \
      # => #    3
      # => #     \
      # => #      4

      def insert(element)
        node = Node.new(element)
        if is_empty?
          @root = node
          @root.level = 1
          @level = 1
          @size += 1
          @leaf_set.insert(node)
          return
        end
        insert_node(node, @root)
      end

      # Delete would delete the element in BST and balance the BST accordingly.
      # The delete option uses the BST property that is every node has lesser value
      # on the left side and larger value lies on the right side.
      # This operation is in O(logn)
      # @param element Element which needs to be deleted from BST
      # @example if tree has values [5,2,3,4,6]
      # => @bst = CollectionUtils::TreeUtils::BST.new([5,2,3,4])
      # => # BST would look like this
      # => #    5
      # => #   / \
      # => #  2   6
      # => #   \
      # => #    3
      # => #     \
      # => #      4
      # => @bst.insert(5)
      # => # Now BST would look like this
      # => #    6
      # => #   /
      # => #  2
      # => #   \
      # => #    3
      # => #     \
      # => #      4
      def delete(element)
        delete_node(element, @root)
      end

      # Leftmost value will be the smallest value returned using this function
      # This operation is in O(logn)
      # @return element which is smallest in the BST
      # @example if tree has values [5,2,3,4,6]
      # => @bst = CollectionUtils::TreeUtils::BST.new([5,2,3,4])
      # => # BST would look like this
      # => #    5
      # => #   / \
      # => #  2   6
      # => #   \
      # => #    3
      # => #     \
      # => #      4
      # => value = @bst.smallest
      # => value == 2
      def smallest
        find_smallest(@root)
      end

      # Rightmost value will be the largest value returned using this function
      # This operation is in O(logn)
      # @return element which is largest in the BST
      # @example if tree has values [5,2,3,4,6]
      # => @bst = CollectionUtils::TreeUtils::BST.new([5,2,3,4])
      # => # BST would look like this
      # => #    5
      # => #   / \
      # => #  2   6
      # => #   \
      # => #    3
      # => #     \
      # => #      4
      # => value = @bst.largest
      # => value == 6
      def largest
        find_largest(@root)
      end

    end
  end
end
