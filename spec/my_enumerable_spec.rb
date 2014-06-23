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

end