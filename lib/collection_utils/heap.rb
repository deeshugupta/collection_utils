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

       # push element to heap
       #
       # @param element object that needs to be added to heap
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

       # pop an element from heap
       #
       # @return removed element
       def delete
         @size -= 1
         node = @leaf_set.get
         @leaf_set.delete(node)
         parent = node.parent
         value = node.val
         if parent.is_leaf?
           @incomplete_set.delete(parent)
           node = nil
           @leaf_set.insert(parent)
         end
         return value
       end

       def root
         @root
       end

       # @return [Integer] size of heap
       def size
        @size
       end

       # @return [Boolean] heap's emptiness
       def is_empty?
        size == 0
       end

       def level
         @level
       end


       # bfs stands for breadth first search.
       # @yield [element] this will take the element returned in bfs manner and execute the passed block.
       # @example Create Heap and in bfs manner assign it to array
       #    arr = [1,2,3,4,5]
       #    heap = CollectionUtils::Heap.new(arr)
       #    x = []
       #    @heap.bfs do |element|
       #      x << element
       #    end
       #    #x = [1,2,3,4,5]
       def bfs
         queue = CollectionUtils::Queue.new
         queue.enqueue(root)
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
       #    @heap.dfs do |element|
       #      x << element
       #    end
       #    #x = [1,3,2,5,4]
       def dfs
         stack = CollectionUtils::Stack.new
         stack.push(root)
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
       def preorder
         arr = []
         pre_order(root, arr)
         return arr
       end

       # Post-Order Traversal of Tree
       #
       # @return [Array] elements of heap in post-ordered manner
       def postorder
         arr = []
         post_order(root, arr)
         return arr
       end

       # In-Order Traversal of Tree
       #
       # @return [Array] elements of heap in in-ordered manner
       def inorder
         arr = []
         in_order(root, arr)
         return arr
       end


    end
    Tree = Heap
end
