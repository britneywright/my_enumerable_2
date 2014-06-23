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
    expect(MyCollection.new(1, 4, 2, 9).find {|element| element + 2 > 5}).to eq 4
    expect(MyCollection.new(1..5).find {|element| element < 3}).to eq 1
    expect(MyCollection.new([]).find {|element| element * 2}).to eq nil
  end
end