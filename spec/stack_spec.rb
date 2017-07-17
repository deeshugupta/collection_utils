require "spec_helper"

RSpec.describe CollectionUtils::Stack do
  it "initializes stack" do
    arr = [1,2,3,4,5]
    stack = CollectionUtils::Stack.new(arr)
    expect(stack.size).to be 5
    expect(stack.peek).to be 5
    expect(stack.pop).to be 5
    expect(stack.size).to be 4
    expect(stack.is_empty?).to be false
    stack.push(6)
    expect(stack.size).to be 5
    expect(stack.peek).to be 6
  end
end
