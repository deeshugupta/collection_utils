module CollectionUtils
  class HashDeserializedObject
    private
    attr_accessor :original

    def convert_name(name)
      attr_name = name.gsub(/([A-Z])([A-Z][a-z])/, '\1_\2')
      attr_name.gsub!(/([a-z])([A-Z])/, '\1_\2')
      return attr_name.to_s.downcase.gsub(/[\s:+!\?\.\|\{\}\[\]\+\-\*\^%$#@]/, "_")
    end

    public
    def initialize(hash = {})
      @original = hash
      hash.each do |key, value|
        insert(key, value)
      end
    end

    # Insert new key value pair in deserialized object.
    # This will create an attr_accessor with key and value as given value
    # @param name key of the hash
    # @param value value of the given jey
    # @example Insert an value in deserialized object and access it
    # => obj = CollectionUtils::HashDeserializedObject.new()
    # => obj.insert(:name, "CollectionUtils")
    # => obj.name # CollectionUtils
    def insert(name, value)
      @original[name] = value
      name = convert_name(name.to_s)
      self.class.send(:attr_accessor, name)
      instance_variable_set("@#{name}", value)
    end

    # Get original Hash used to build the object. It will grow as we insert more
    # values in the object
    # @return [Hash] original hash used to build the object
    # @example Create Object from hash, change the hash and get original
    # => hash = {:message1 => "welcome", :message2 => "to" }
    # => hash_new = CollectionUtils::HashDeserializedObject.new(hash)
    # => hash_new(:message3, "Collections")
    # => hash = hash_new.get_serialized_object # hash = {:message1 => "welcome", :message2 => "to", :message3 => "collections"}
    def get_serialized_object
      return @original
    end
  end
end

class Hash
  def to_hash_deserialized_object
    return CollectionUtils::HashDeserializedObject.new(self)
  end
end
