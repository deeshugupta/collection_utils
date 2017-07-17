require_relative './heap'
module CollectionUtils
  module HeapUtils
    class MinHeap < Heap

      private
      attr_accessor :heap

      public
      def initialize(array = [])
        @heap = array
      end
    end
  end
end
