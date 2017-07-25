module CollectionUtils
  class Set
    private
    attr_accessor :set

    def get_key_value(val)
      instance_variables = val.instance_variables
      if instance_variables.empty?
        return val.hash, val
      end
      variables = instance_variables.inject(Hash.new(0)) {|h,e|
        h[e] = val.instance_variable_get(e);h
      }
      return variables.hash, val
    end

    public
    def initialize(values = [])
      @set = {}
      values.each do |value|
        insert(value)
      end
    end

    # Insert an element into set. This is done in O(1) operations
    #
    # @param val element that needs to be added
    # @return [Boolean] true if element is added, false if element is already present
    # @example Add element into set
    # => set = CollectionUtils::Set.new([1,2,3,4])
    # => set.size #4
    # => set.insert(5)
    # => set.size #5
    # => set.insert(4)
    # => set.size #5
    def insert(val)
      key, value = get_key_value(val)
      @set[key] = value; return true if @set[key].nil?
      return false
    end

    # checks whether an element is present or not.
    # This is done in O(1) operations
    # @param val which has to be checked whether in set or not
    # @return [Boolean] true if element is present, false if element is already present
    # @example check an element in set
    # => set = CollectionUtils::Set.new([1,2,3,4])
    # => set.check(4) #true
    # => set.check(5) #false
    def check(val)
      key, value = get_key_value(val)
      return !@set[key].nil?
    end

    # deletes an element from the set.
    # This is done in O(1) operations
    # @param val which has to be deleted
    # @example check an element in set
    # => set = CollectionUtils::Set.new([1,2,3,4])
    # => set.delete(4) #set = [1,2,3]
    # => set.delete(5) #set = [1,2,3]
    def delete(val)
      key, value = get_key_value(val)
      @set.delete(key)
    end


    # Get a random element from the set.
    #
    # @return a random element from set.
    # @example get an element from set
    # => set = CollectionUtils::Set.new([1,2,3,4])
    # => set.get # 3
    # => set.get # 4
    # => set.get # 3
    def get
      @set.values.sample
    end

    # Get all the values from a set.
    #
    # @return all the elements from the set.
    # @example get all element from set
    # => set = CollectionUtils::Set.new([1,2,3,4])
    # => set.get_values #[1,2,3,4]
    def get_values
      @set.values
    end

    # @return [Integer] size of the
    # @example return size of set
    # => set = CollectionUtils::Set.new([1,2,3,4])
    # => set.size #4
    def size
      @set.keys.size
    end

    # Returns whether the set is empty. This is just a syntax_sugar
    # for size == 0
    # @return [Boolean] set's emptiness
    def is_empty?
      size == 0
    end

    # Intersection of two sets and return the intersected set
    #
    # @param [Set] set with which Intersection of the current set needs to be taken
    # @return [Set] intersected set
    # @example Intesect two sets and return it.
    # => set1 = CollectionUtils::Set.new([1,2,3,4])
    # => set2 = CollectionUtils::Set.new([2,3,4,5])
    # => set3 = set1 & set2 #[2,3,4]
    def &(set)
      new_set = Set.new(get_values & set.get_values)
      return new_set
    end

    # Union of two sets and return the united set
    #
    # @param [Set] set with which Union of the current set needs to be taken
    # @return [Set] united set
    # @example Union two sets and return it.
    # => set1 = CollectionUtils::Set.new([1,2,3,4])
    # => set2 = CollectionUtils::Set.new([2,3,4,5])
    # => set3 = set1 + set2 #[1,2,3,4,5]
    def +(set)
      new_set = Set.new(get_values + set.get_values)
      return new_set
    end

    # Difference of two sets and return the subtracted set
    #
    # @param [Set] set with which Difference of the current set needs to be taken
    # @return [Set] subtracted set
    # @example subtracted two sets and return it.
    # => set1 = CollectionUtils::Set.new([1,2,3,4])
    # => set2 = CollectionUtils::Set.new([2,3,4,5])
    # => set3 = set1 - set2 #[1]
    def -(set)
      new_set = Set.new(get_values - set.get_values)
    end

  end
end
