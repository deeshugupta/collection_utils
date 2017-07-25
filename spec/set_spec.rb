# -*- encoding: utf-8 -*-

require 'spec_helper'
require 'collection_utils/set'

describe CollectionUtils::Set do

  before(:each) do
    arr = [4,6,3,2,5,1]
    @set = CollectionUtils::Set.new(arr)
  end

  it 'get size of the set' do
    result = @set.size
    expect(result).to eq(6)
  end

  it 'should insert new value' do
    size  = @set.size
    @set.insert(7)
    expect(@set.size).to eq(size+1)
  end

  it 'should not insert new value' do
    size  = @set.size
    @set.insert(6)
    expect(@set.size).to eq(size)
  end


  it 'should check the value to be present' do
    result = @set.check(5)
    expect(result).to be true
  end

  it 'should check the value to be absent' do
    result = @set.check(100)
    expect(result).to be false
  end


  it 'should delete the value' do
    @set.insert(10)
    size = @set.size
    @set.delete(10)
    expect(@set.size).to eq(size - 1)
  end


  it 'should get some random value' do
    result = @set.get
    expect(result).not_to be_nil
  end

  it 'get all values' do
    @set.insert(20)
    result = @set.get_values
    expect(result.include?(20)).to be true
  end

  it 'should check set\'s emptiness ' do
    result = @set.is_empty?
    expect(result).to be false
  end



  it 'intersect' do
    set1 = CollectionUtils::Set.new([1,2,3,4,5])
    set2 = CollectionUtils::Set.new([3,4,5,6,7])

    result = set1 & set2
    expect(result.size).to eq(3)
    expect(result.check(3)).to be true
    expect(result.check(4)).to be true
    expect(result.check(5)).to be true
    expect(result.check(6)).to be false
  end


  it 'union' do
    set1 = CollectionUtils::Set.new([1,2])
    set2 = CollectionUtils::Set.new([3,4])

    result = set1 + set2
    expect(result.size).to eq(4)
    expect(result.check(3)).to be true
    expect(result.check(4)).to be true
    expect(result.check(2)).to be true
    expect(result.check(1)).to be true
  end


  it 'difference' do
    set1 = CollectionUtils::Set.new([1,2,3,4,5])
    set2 = CollectionUtils::Set.new([3,4,5,6,7])

    result = set1 - set2
    expect(result.size).to eq(2)
    expect(result.check(1)).to be true
    expect(result.check(2)).to be true
    expect(result.check(5)).to be false
    expect(result.check(6)).to be false
  end

end
