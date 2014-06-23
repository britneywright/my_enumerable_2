require 'my_enumerable'

describe "MyEnumerable module contains my Enumerable methods" do
  class MyCollection
    include MyEnumerable
    def initialize(collection)
      @collection = collection
    end

    def each
      @collection.each {|element| yield element}
    end
  end

  specify "#count totals the number of elements in the collection" do
    expect(MyCollection.new([1,2,3,6]).count).to eq 4
    expect(MyCollection.new(1...5).count).to eq 4
    expect(MyCollection.new([]).count).to eq 0
  end

  specify "#find returns the first element of the collection which makes the block truthy" do
    expect(MyCollection.new([1, 4, 2, 9]).find {|element| element + 2 > 5}).to eq 4
    expect(MyCollection.new(1..5).find {|element| element < 3}).to eq 1
    expect(MyCollection.new([]).find {|element| element * 2}).to eq nil
  end

  specify "#select returns new collection of requested elements from collection" do
    expect(MyCollection.new(1..5).select {|element| element < 3}).to eq [1, 2]
    expect(MyCollection.new([3, 1, 6, 9]).select {|element| element % 3 == 0}).to eq [3, 6, 9]
    expect(MyCollection.new([]).select {|element| element }).to eq []
    expect(MyCollection.new(1...5).select {|element| element >= 5}).to eq []
  end  

  specify "#map returns new collection of elements transformed after passing into block" do
    expect(MyCollection.new(1...5).map {|element| element + 3}).to eq [4, 5, 6, 7]
    expect(MyCollection.new([3, 1, 6, 9]).map {|element| element * 3 }).to eq [9, 3, 18, 27]
    expect(MyCollection.new([]).map {|element| element * 2 }).to eq []
  end

  specify "#first returns the first element of the collection" do
    expect(MyCollection.new(1..5).first).to eq 1
    expect(MyCollection.new([3, 1, 6, 9]).first).to eq 3
    expect(MyCollection.new([]).first).to eq nil
  end

  specify "#min returns the smallest element of the collection" do
    expect(MyCollection.new(1..5).min).to eq 1
    expect(MyCollection.new([3, 1, 6, 9]).min).to eq 1
    expect(MyCollection.new([]).min).to eq nil
  end

  specify "#include? returns true if specific element is in collection or false if not" do
    expect(MyCollection.new(1...5).include?(5)).to eq false
    expect(MyCollection.new([3, 1, 6, 9]).include?(6)).to eq true
    expect(MyCollection.new([]).include?(5)).to eq false
  end       
end