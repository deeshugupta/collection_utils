module CollectionUtils
    class Heap
      private
      attr_accessor :heap

      protected


      #
      # @return element which is at the root of the tree
      def root
        return @heap.first
      end


      # Traverse the tree in pre-order manner
      #
      # @param node current node being parsed
      # @param [Array] arr which will contain the nodes of tree in pre-order manner
      def pre_order(node, arr)
        return if node.nil?
        left = left(node.index)
        right = right(node.index)

        arr << node.element
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
        left = left(node.index)
        right = right(node.index)

        post_order(left, arr) unless left.nil?
        post_order(right, arr) unless right.nil?
        arr << node.element
        return
      end


      # Traverse the tree in in-order manner
      #
      # @param node current node being parsed
      # @param [Array] arr which will contain the nodes of tree in in-order manner
      def in_order(node, arr)
        return if node.nil?
        left = left(node.index)
        right = right(node.index)

        in_order(left, arr) unless left.nil?
        arr << node.element
        in_order(right, arr) unless right.nil?
        return
      end


      # @param [Integer] parent is the index for which left child needs to be founded. Default is 0
      # @return left_child and index of that left child
      def left_child(parent = 0)
        left = (2*parent + 1)
        return nil, nil if @heap[left].nil?
        return @heap[left], left
      end


      # @param [Integer] parent is the index for which right child needs to be founded. Default is 0
      # @return right_child and index of that right child
      def right_child(parent = 0)
        right = (2*parent + 2)
        return nil, nil if @heap[right].nil?
        return @heap[right], right
      end


      # @param parent is the index for which left child is added. Default is 0
      # @param node is the element which needs to be assigned to left of the parent
      def assign_left(parent = 0, node)
        left = (2*parent + 1)
        node.index = left
        @heap[left] = node
      end


      # @param parent is the index for which right child is added. Default is 0
      # @param node is the element which needs to be assigned to right of the parent
      def assign_right(parent = 0, node)
        right = (2*parent + 2)
        node.index = right
        @heap[right] = node
      end

      # @param parent for which left child index needs to be found
      # @return [Integer] left child index
      def left_index(parent = 0)
        left = (2*parent + 1)
      end

      # @param parent for which right child index needs to be found
      # @return [Integer] right child index
      def right_index(parent = 0)
        right = (2*parent + 2)
      end

      # @param child for which parent needs to be found
      # @return element and parent index
      def parent(child = 0)
        par = child/2
        return @heap[par], par
      end


      public
      #Constructors
      def initialize(array = [])
        @heap = []
        array.each do |element|
          push(element)
        end
      end

       #Public methods

       # @param [Integer] parent index for which left child needs to be returned
       # @return left child
       def left(parent = 0)
         left_child(parent).first
       end

       # @param [Integer] parent index for which right child needs to be returned
       # @return right child
       def right(parent = 0)
         right_child(parent).first
       end

       # push element to heap
       #
       # @param element object that needs to be added to heap
       def insert(element)
         @heap << CollectionUtils::HashDeserializedObject.new({
           element: element,
           index: size
           })
       end

       alias :push :insert

       # pop an element from heap
       #
       # @return removed element
       def delete
         element = @heap.pop
         return element.element
       end

       alias :pop :delete


       # @return [Integer] size of heap
       def size
         return @heap.size
       end

       # @return [Boolean] heap's emptiness
       def is_empty?
         return size == 0
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
           left = left(node.index)
           right = right(node.index)
           yield(node.element) if block_given?
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
           left = left(node.index)
           right = right(node.index)
           yield(node.element) if block_given?
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
