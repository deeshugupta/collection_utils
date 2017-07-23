require "spec_helper"

RSpec.describe CollectionUtils::Heap do
  before(:each) do
    arr = [1,2,3,4,5]
    @heap = CollectionUtils::Heap.new(arr)
  end
  it "initializes Heap" do
    expect(@heap.size).to be 5
  end

  it "tests bfs" do
    x = []
    @heap.bfs do |element|
      x << element
    end
    expect(x.size).to be 5
  end

  it "tests dfs" do
    x = []
    @heap.dfs do |element|
      x << element
    end
    expect(x.size).to be 5
  end
end
