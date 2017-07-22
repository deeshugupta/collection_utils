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
        h[e] = x.instance_variable_get(e);h
      }
      return variables.hash, val
    end

    public
    def initialize(values = [])
      @set = {}
      values.each do |value|
        push(value)
      end
    end

    def push(val)
      key, value = get_key_value(val)
      @set[key] = value if @set[key].nil?
    end

    def check(val)
      key, value = get_key_value(val)
      return @set[key].nil?
    end

    def delete(val)
      key, value = get_key_value(val)
      @set.delete(key)
    end

    def get
      @set.values.sample
    end

    def get_values
      @set.values
    end

    def size
      @set.size
    end

    def is_empty?
      size == 0
    end

    def &(set)
      new_set = Set.new(get_values & set.get_values)
      return new_set
    end

    def +(set)
      new_set = Set.new(get_values + set.get_values)
      return new_set
    end

    def -(set)
      new_set = Set.new(get_values - set.get_values)
    end

  end
end
