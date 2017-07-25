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

    def method_missing(method_name, *args, &block)
      if method_name.to_s.include?"="
        insert(method_name.to_s.split("=").first, args.first)
      else
        insert(method_name, nil)
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
      if value.class.name == "Hash" || value.class.superclass.name == "Hash"
        value = CollectionUtils::HashDeserializedObject.new(value)
      end
      name = convert_name(name.to_s)
      self.class.send(:attr_accessor, name)
      instance_variable_set("@#{name}", value)
    end


    # Delete the key value pair from deserialized object.
    # This will rmeove the attr_accessor from object and key value from hash.
    # @param name attr_accessor name to be deleted
    # @return  value of the deleted attribute
    # @example Delete from object
    # => obj = CollectionUtils::HashDeserializedObject.new()
    # => obj.insert(:name, "CollectionUtils")
    # => obj.name #CollectionUtils
    # => obj.insert(:type, "HashDeserializedObject")
    # => obj.type #HashDeserializedObject
    # => value = obj.delete(:name) #CollectionUtils
    # => obj.get_serialized_object #{type: "HashDeserializedObject"}
    def delete(name)
      @original.delete(name)
      return remove_instance_variable("@#{name.to_s}")
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
