# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'collection_utils/version'

Gem::Specification.new do |spec|
  spec.name          = "collection_utils"
  spec.version       = CollectionUtils::VERSION
  spec.authors       = ["deeshugupta"]
  spec.email         = ["gupta.deeshu@gmail.com"]

  spec.summary       = ""
  spec.description   = "CollectionUtils provide with basic collection templates
  like stack(push, pop, peek), queues(enqueue, dequeue), heaps/tree(MinHeap, MaxHeap, BST)
  and HashDeserializedObject(Converts a hash into object for easy access.
  All the keys will become attributes of the object). 
  Check out the wiki at https://github.com/deeshugupta/collection_utils/wiki"
  spec.homepage      = "https://github.com/deeshugupta/collection_utils"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
