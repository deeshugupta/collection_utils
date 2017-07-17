require "spec_helper"

RSpec.describe CollectionUtils::Queue do
  it "initializes queue" do
    arr = [1,2,3,4,5]
    queue = CollectionUtils::Queue.new(arr)
    expect(queue.size).to be 5
    expect(queue.rear).to be 5
    expect(queue.front).to be 1
    expect(queue.dequeue).to be 1
    expect(queue.size).to be 4
    expect(queue.is_empty?).to be false
    queue.enqueue(6)
    expect(queue.size).to be 5
    expect(queue.rear).to be 6
  end
end
