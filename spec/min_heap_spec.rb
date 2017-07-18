require "spec_helper"

RSpec.describe CollectionUtils::HeapUtils::MinHeap do
  before(:each) do
    a_1 = Num.new(1,2)
    a_2 = Num.new(2,2)
    a_3 = Num.new(3,2)
    a_4 = Num.new(1,5)
    a_5 = Num.new(6,2)
    a_6 = Num.new(1,1)
    arr = [
      a_1,
      a_2,
      a_3,
      a_4,
      a_5,
      a_6
    ]
    @heap = CollectionUtils::HeapUtils::MinHeap.new(arr)
  end
  it "initializes Heap" do
    expect(@heap.get_min.size).to be 1
  end

  it "should extract minumum" do
    @heap.extract_min
    @heap.extract_min
    @heap.extract_min
    element = @heap.extract_min
    expect(element.value).to be 3
    expect(element.size).to be 2
  end

  it "should replace the minimum" do
    @heap.insert(Num.new(-4,5))
    element = @heap.extract_min
    expect(element.value).to be -4
    expect(element.size).to be 5
  end

end

class Num
  include Comparable

  def <=>(other)
    value + size <=> other.value + other.size
  end
  attr_accessor :value, :size
  def initialize(value, size)
    @value = value
    @size = size
  end
end
