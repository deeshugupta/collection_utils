module CollectionUtils
    class Heap
      private
      attr_accessor :root, :incomplete_set, :leaf_set, :size, :level

      class Node
        attr_accessor :val, :left, :right, :parent, :level

        def initialize(val, left=nil, right=nil, parent=nil, level=nil)
          @val = val
          @left = left
          @right = right
          @parent = parent
          @level = level
        end

        def is_leaf?
          left.nil? && right.nil?
        end

        def is_full?
          !left.nil? && !right.nil?
        end

        def is_incomplete?
          (!left.nil? && right.nil?) || (left.nil? && !right.nil?)
        end

      end

      private_constant :Node

      protected
      # Traverse the tree in pre-order manner
      #
      # @param node current node being parsed
      # @param [Array] arr which will contain the nodes of tree in pre-order manner
      def pre_order(node, arr)
        return if node.nil?
        left = node.left
        right = node.right

        arr << node.val
        pre_order(left, arr) unless left.nil?
        pre_order(right, arr) unless right.nil?

        return
      end


      # Traverse the tree in post-order manner
      #
      # @param node current node being parsed
      # @param [Array] arr which will contain the nodes of tree in post-order manner
      def post_order(node, arr)
        return if node.nil?
        left = node.left
        right = node.right

        post_order(left, arr) unless left.nil?
        post_order(right, arr) unless right.nil?
        arr << node.val
        return
      end


      # Traverse the tree in in-order manner
      #
      # @param node current node being parsed
      # @param [Array] arr which will contain the nodes of tree in in-order manner
      def in_order(node, arr)
        return if node.nil?
        left = node.left
        right = node.right

        in_order(left, arr) unless left.nil?
        arr << node.val
        in_order(right, arr) unless right.nil?
        return
      end


      public
      #Constructors
      def initialize(array = [])
        @size = 0
        @root = nil
        @incomplete_set = CollectionUtils::Set.new()
        @leaf_set = CollectionUtils::Set.new()
        array.each do |element|
          insert(element)
        end
      end

       # Adds an element to the heap. This is done in O(1) operations and
       # preference is given to incomplete nodes as compared to leaf nodes
       # @param element object that needs to be added to heap
       # => @heap = CollectionUtils::Heap.new([5,2,6,4,3])
       # => #      5
       # => #     / \
       # => #    2   6
       # => #   / \
       # => #  4   3
       # => @heap.insert(7)
       # => #        5
       # => #      /  \
       # => #    2     6
       # => #   / \   /
       # => #  4   3 7
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
             @incomplete_set.insert(parent_node) if parent_node.right.nil?
             @leaf_set.insert(node)
             return
           end
           if parent_node.right.nil?
             node.parent = parent_node
             node.level = parent_node.level + 1
             parent_node.right = node
             @level = node.level if node.level > @level
             @incomplete_set.insert(parent_node) if parent_node.left.nil?
             @leaf_set.insert(node)
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
           @incomplete_set.insert(parent_node)
           @leaf_set.insert(node)
           return
         end

       end

       # Removes a random element from the leaf set and
       # deletes it. This is done in O(1) operations.
       # @return removed element
       # @example delete from heap [5,2,6,4,3]
       # => @heap = CollectionUtils::Heap.new([5,2,6,4,3])
       # => #      5
       # => #     / \
       # => #    2   6
       # => #   / \
       # => #  4   3
       # => @heap.delete == 4 or 3 or 6
       def delete
         @size -= 1
         node = @leaf_set.get
         @leaf_set.delete(node)
         parent = node.parent
         value = node.val
         if parent.is_incomplete?
           @incomplete_set.delete(parent)
           parent.left == node ? parent.left = nil : parent.right = nil
           node = nil
           @leaf_set.insert(parent) if parent.is_leaf?
         else
           parent.left == node ? parent.left = nil : parent.right = nil
           node = nil
           @incomplete_set.insert(parent)
         end
         return value
       end

       # Returns the root of the tree
       #
       # @return element which is present at the root of the heap or tree
       # @example Root of heap [5,2,6,4,3]
       # => @heap = CollectionUtils::Heap.new([5,2,6,4,3])
       # => #      5
       # => #     / \
       # => #    2   6
       # => #   / \
       # => #  4   3
       # => @heap.root == 5
       def root
         @root.val
       end

       # Returns the number of elements in a tree or heap. This is returned in
       # O(1) operations as we are storing the size of the tree which is
       # otherwise O(n) operations.
       # @return [Integer] size of heap
       def size
        @size
       end

       # Returns whether the heap or tree is empty. This is just a syntax_sugar
       # for size == 0
       # @return [Boolean] heap's emptiness
       def is_empty?
        size == 0
       end

       # Returns the level of the tree. This is returned in O(1) operations
       # as we are storing the level of the tree which is otherwise a costly
       # operation
       #
       # @return [Integer] height or level of the heap or tree
       def level
         @level
       end


       # bfs stands for breadth first search.
       # @yield [element] this will take the element returned in bfs manner and execute the passed block.
       # @example Create Heap and in bfs manner assign it to array
       #    arr = [1,2,3,4,5]
       #    heap = CollectionUtils::Heap.new(arr)
       #    x = []
       #    heap.bfs do |element|
       #      x << element
       #    end
       #    #x = [1,2,3,4,5]
       def bfs
         queue = CollectionUtils::Queue.new
         queue.enqueue(@root)
         while true do
           node = queue.dequeue
           next if node.nil?
           left = node.left
           right = node.right
           yield(node.val) if block_given?
           queue.enqueue(left) unless left.nil?
           queue.enqueue(right) unless right.nil?
           break if queue.is_empty?
         end

       end

       # dfs stands for depth first search.
       # @yield [element] this will take the element returned in dfs manner and execute the passed block.
       # @example Create Heap and in dfs manner assign it to array
       #    arr = [1,2,3,4,5]
       #    heap = CollectionUtils::Heap.new(arr)
       #    x = []
       #    heap.dfs do |element|
       #      x << element
       #    end
       #    #x = [1,3,5,4,2]
       def dfs
         stack = CollectionUtils::Stack.new
         stack.push(@root)
         while true do
           node = stack.pop
           next if node.nil?
           left = node.left
           right =node.right
           yield(node.val) if block_given?
           stack.push(left) unless left.nil?
           stack.push(right) unless right.nil?
           break if stack.is_empty?
         end
       end

       # Pre-Order Traversal of Tree
       #
       # @return [Array] elements of heap in pre-ordered manner
       # @example Preorder Traversal for heap [5,2,6,4,3]
       # => @heap = CollectionUtils::Heap.new([5,2,6,4,3])
       # => #      5
       # => #     / \
       # => #    2   6
       # => #   / \
       # => #  4   3
       # => arr = @heap.preorder #arr = [5,2,4,3,6]
       def preorder
         arr = []
         pre_order(@root, arr)
         return arr
       end

       # Post-Order Traversal of Tree
       #
       # @return [Array] elements of heap in post-ordered manner
       # @example Postorder Traversal for heap [5,2,6,4,3]
       # => @heap = CollectionUtils::Heap.new([5,2,6,4,3])
       # => #      5
       # => #     / \
       # => #    2   6
       # => #   / \
       # => #  4   3
       # => arr = @heap.postorder #arr = [4,3,2,6,5]
       def postorder
         arr = []
         post_order(@root, arr)
         return arr
       end

       # In-Order Traversal of Tree
       #
       # @return [Array] elements of heap in in-ordered manner
       # @example Inorder Traversal for heap [5,2,6,4,3]
       # => @heap = CollectionUtils::Heap.new([5,2,6,4,3])
       # => #      5
       # => #     / \
       # => #    2   6
       # => #   / \
       # => #  4   3
       # => arr = @heap.inorder #arr = [4,2,3,5,6]
       def inorder
         arr = []
         in_order(@root, arr)
         return arr
       end


    end
    Tree = Heap
end
