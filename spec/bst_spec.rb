require "spec_helper"

RSpec.describe CollectionUtils::TreeUtils::BST do
  before(:each) do
    arr = [4,6,3,2,5,1]
    @bst = CollectionUtils::TreeUtils::BST.new(arr)
  end
  it "finds smallest" do
    expect(@bst.smallest).to be 1
  end
  it "finds largest" do
    expect(@bst.largest).to be 6
  end

  it "tests inorder" do
    expect(@bst.inorder).to eq([1,2,3,4,5,6])
  end

  it "tests preorder" do
    expect(@bst.preorder).to eq([4, 3, 2, 1, 6, 5])
  end

  it "tests postorder" do
    expect(@bst.postorder).to eq([1, 2, 3, 5, 6, 4])
  end

end
