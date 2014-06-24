module MyEnumerable
  def count
    count = 0
    self.each {count += 1}
    count
  end

  def find
    self.each do |element|
      if yield(element)
        return element
      end
    end
    return nil
  end

  def select
    ary = []                # => []
    self.each do |element|  # => #<MyCollection:0x00000101972ca8 @collection=[3, 4, 5]>
      if yield(element)     # => 3, 4, 5
        ary << element      # => [3], [3, 4], [3, 4, 5]
      end                   # => [3], [3, 4], [3, 4, 5]
    end                     # => [3, 4, 5]
    ary                     # => [3, 4, 5]
  end

  def map
    ary = []
    self.each do |element|
      ary << yield(element)
    end
    ary
  end

  def first
    self.each do |element|
      return element
    end
    return nil
  end

  def min
    smallest = self.first
    self.each do |element|
      if element < smallest
        smallest = element
      end
    end
    smallest
  end

  def include?(target)
    self.each do |element|
      if element == target
        return true
      end
    end
    return false
  end

  def min_by
    smallest = yield(self.first)
    value = self.first
    self.each do |element|
      if yield(element) < smallest
        smallest = yield(element)
        value = element
      end
    end
    value
  end

  def all?
    self.each do |element|
      unless yield(element)
        return false
      end 
    end
    return true
  end

  def take(target)
    ary = []
    count = 0
    self.each do |element|
      count += 1
      if count <= target
        ary << element
      end
    end
    ary
  end

  def any?
    if block_given?                                 # => false
      self.each do |element|
        if yield(element)
          return true
        end
      end
    elsif self.select{|element| element}.count > 0  # => true
      return true                                   # => true
    end
    return false
  end

  def none?
    if block_given?
      self.each do |element|
        if yield(element)
          return false
        end
      end
    elsif self.select{|element| element}.count > 0
      return false
    end
    return true
  end
end

class MyCollection
  include MyEnumerable        # => MyCollection
  def initialize(collection)
    @collection = collection  # => [3, 4, 5]
  end

  def each
    @collection.each {|element| yield element}  # => [3, 4, 5]
  end
end