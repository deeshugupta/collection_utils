require_relative '../heap'
module CollectionUtils
  module TreeUtils
    class BST < CollectionUtils::Tree
      private

      def delete_node(element, node)
        if element == node.val
          @leaf_set.delete(node)
          if node.is_leaf?
            parent = node.parent
            @leaf_set.delete(parent)
            parent.left == node ? parent.left = nil : parent.right = nil
            @leaf_set.insert(parent) if parent.is_leaf?
            return
          elsif node.right.is_leaf?
            node.val = node.right.val
            node.right = nil
            @leaf_set.insert(node) if node.is_leaf?
            return
          elsif node.left.is_leaf?
            node.val = node.left.val
            node.left = nil
            @leaf_set.insert(node) if node.is_leaf?
            return
          else
            smallest = find_smallest(node)
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
        smallest = nil
        right = node.right
        unless right.nil?
          smallest = right
          left = right.left
          while !left.nil?
            smallest = left
            left = left.left
          end
        end
      end

      def insert(node, parent_node)
        if node.val >= parent_node.val
          if parent_node.right.nil?
            @leaf_set.delete(parent_node)
            parent_node.right = node
            node.level = parent_node.level + 1
            @level = node.level if node.level > @level
            @leaf_set.insert(node) if node.is_leaf?
            return
          else
            insert(node, parent_node.right)
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
            insert(node, parent_node.left)
          end
        end
      end

      public
      def initialize(arr = [])
        arr.each do |element|
          insert(element, root)
        end
      end

      def insert(element)
        node = Node.new(element)
        if is_empty?
          @root = node
          @root.level = 1
          @level = 1
          @leaf_set.insert(node)
          return
        end
        insert(node, @root)
      end

      def delete(element)
        delete_node(element, @root)
      end

    end
  end
end
